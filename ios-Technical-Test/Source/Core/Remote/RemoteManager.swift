//
//  AuthManager.swift
//  iosTechnicalTest
//
//  Created by JORDI GALLEN on 11/08/2020.
//  Copyright © 2020 JORDI GALLEN RENAU. All rights reserved.
//

import Alamofire
import UIKit

private struct AuthTags {
    static let authorization = "Authorization"
    static let sessionToken = "jwt"
}

private struct Empty {
    static let response = 500
}

public protocol RemoteManagerProtocol: AnyObject {
    func post<Response: Codable>(_ endpoint: String, headers: [String: String], parameters: Codable?, authType: AuthType, completion: @escaping RemoteCompletionTypeAlias<Response>)
    func get<Response: Codable>(_ endpoint: String, headers: [String: String], parameters: Codable?, authType: AuthType, completion: @escaping RemoteCompletionTypeAlias<Response>)
    func put<Response: Codable>(_ endpoint: String, headers: [String: String], parameters: Codable?, authType: AuthType, completion: @escaping RemoteCompletionTypeAlias<Response>)
    func delete<Response: Codable>(_ endpoint: String, headers: [String: String], parameters: Codable?, authType: AuthType, completion: @escaping RemoteCompletionTypeAlias<Response>)
}

extension RemoteManagerProtocol {
    func post<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType = .none, completion: @escaping RemoteCompletionTypeAlias<Response>) {
        self.post(endpoint, headers: headers, parameters: parameters, authType: authType, completion: completion)
    }

    func get<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType = .none, completion: @escaping RemoteCompletionTypeAlias<Response>) {
        self.get(endpoint, headers: headers, parameters: parameters, authType: authType, completion: completion)
    }

    func put<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType = .none, completion: @escaping RemoteCompletionTypeAlias<Response>) {
        self.put(endpoint, headers: headers, parameters: parameters, authType: authType, completion: completion)
    }

    func delete<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType = .none, completion: @escaping RemoteCompletionTypeAlias<Response>) {
        self.delete(endpoint, headers: headers, parameters: parameters, authType: authType, completion: completion)
    }
}

public class RemoteManager: RemoteManagerProtocol {
    private enum Header {
        static let accept = "Accept"
        static let contentType = "Content-Type"
        static let applicationJson = "application/json"
        static let ApiKeyName = "apiKey"
        static let acceptLanguage = "Accept-Language"
    }

    private var configuration: RemoteConfiguration
    private let baseUrl: String

    public init(_ configuration: RemoteConfiguration) {
        self.configuration = configuration
        self.baseUrl = configuration.baseUrl
    }

    public func post<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType = .none,
                                        completion: @escaping RemoteCompletionTypeAlias<Response>) {
        self.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers, authType: authType) { response in
            completion(response)
        }
    }

    public func get<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType = .none,
                                       completion: @escaping RemoteCompletionTypeAlias<Response>) {
        self.request(endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers, authType: authType) { response in
            completion(response)
        }
    }

    public func put<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType = .none,
                                       completion: @escaping RemoteCompletionTypeAlias<Response>) {
        self.request(endpoint, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers, authType: authType) { response in
            completion(response)
        }
    }

    public func delete<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType = .none,
                                          completion: @escaping RemoteCompletionTypeAlias<Response>) {
        self.request(endpoint, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers, authType: authType) { response in
            completion(response)
        }
    }

    // swiftlint:disable cyclomatic_complexity function_body_length
    internal func request<Response: Codable>(_ endpoint: String,
                                             method: HTTPMethod,
                                             parameters: Codable?,
                                             encoding: ParameterEncoding = JSONEncoding.default,
                                             headers: [String: String] = [:],
                                             authType: AuthType = .none,
                                             completion: @escaping RemoteCompletionTypeAlias<Response>) {
        guard let url = URL(string: self.baseUrl + endpoint) else { return }

        let request = parameters?.dictionary
        let newHeaders = self.build(headers: headers, by: authType)
        self.configuration.session
            .request(url, method: method, parameters: request, encoding: encoding, headers: newHeaders)
            .validate(contentType: ["application/json"])
            .responseData { [weak self] dataResponse in
                guard let self = self else { return }
                if let data = dataResponse.data, let stringResponse: String = String(data: data, encoding: .utf8) {
                    CoreLog.remote.debug("Request: %@", url.description)
                    CoreLog.remote.debug("Response: %@", stringResponse)
                }
                if let response = dataResponse.response {
                    let statusCode = response.statusCode
                    guard statusCode >= 200, statusCode < 300 else {
                        ErrorManager.process(response)
                        return
                    }

                    switch dataResponse.result {
                    case let .success(data):
                        do {
                            if let response: Response = try self.convertFrom(data: data) {
                                if  data.count < Empty.response {
                                    self.receiveEmptyResults()
                                } else {
                                    completion(.success(response))
                                }
                            } else {
                                completion(.failure(.remoteError(.reason(dataResponse.error?.localizedDescription ?? "Wrong response received"))))
                            }
                        } catch {
                            ErrorManager.process(error: error.localizedDescription)
                        }
                    case let .failure(error):
                        ErrorManager.process(error: error.localizedDescription)
                    }
                } else {
                    ErrorManager.process(error: dataResponse.error?.localizedDescription ?? "Networking error connection")
                }
            }
    }

    private func build(headers: HTTPHeaders, by type: AuthType) -> HTTPHeaders {
        var newHeaders = headers
        newHeaders[Header.accept] = Header.applicationJson
        newHeaders[Header.contentType] = Header.applicationJson
        newHeaders[Header.acceptLanguage] = Locale.current.identifier

        newHeaders.merge(self.configuration.defaultHeaders) { current, _ in current }

        switch type {
        case let .other(authHeader):
            authHeader.forEach { key, value in
                newHeaders[key] = value
            }
        case .none:
            newHeaders[AuthTags.authorization] = nil
            newHeaders[AuthTags.sessionToken] = nil
        }

        return newHeaders
    }

    private func convertFrom<Response: Codable>(data: Data) throws -> Response? {
        return try? JSONDecoder().decode(Response.self, from: data)
    }

    func receiveEmptyResults() {
        NotificationCenter.default.post(name: Notification.Name.Response.emptyData, object: nil)
    }
}
