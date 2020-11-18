//
//  MockRemoteManager.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import ios_Technical_Test

enum HttpMethod: Hashable, CaseIterable {
    case get, post, put, delete
}

class MockRemoteManager {
    private var responses: [HttpMethod: [String: Result<Codable, BaseError>]] = [
        .get: [:],
        .post: [:],
        .put: [:],
        .delete: [:],
    ]

    private var ignoreParametersInKeys: Bool

    init(ignoreParametersInKeys: Bool = false) {
        self.ignoreParametersInKeys = ignoreParametersInKeys
    }

    func registerResponse(_ response: Result<Codable, BaseError>, forMethod method: HttpMethod, withEndpoint endpoint: String, withParameters parameters: Codable?) {
        self.responses[method]?[computeKey(using: endpoint, and: parameters)] = response
    }

    func cleanRegisteredResponses() {
        HttpMethod.allCases.forEach {
            responses[$0]?.removeAll()
        }
    }
}

extension MockRemoteManager: RemoteManagerProtocol {

    func post<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType, completion: @escaping RemoteCompletionTypeAlias<Response>) {
        executeClosure(completion, with: retrieveResponse(forMethod: .post, endpoint: endpoint, parameters: parameters))
    }

    func get<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType, completion: @escaping RemoteCompletionTypeAlias<Response>) {
        executeClosure(completion, with: retrieveResponse(forMethod: .get, endpoint: endpoint, parameters: parameters))
    }

    func put<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType, completion: @escaping RemoteCompletionTypeAlias<Response>) {
        executeClosure(completion, with: retrieveResponse(forMethod: .put, endpoint: endpoint, parameters: parameters))
    }

    func delete<Response: Codable>(_ endpoint: String, headers: [String: String] = [:], parameters: Codable?, authType: AuthType, completion: @escaping RemoteCompletionTypeAlias<Response>) {
        executeClosure(completion, with: retrieveResponse(forMethod: .delete, endpoint: endpoint, parameters: parameters))
    }

    func download<Response>(_ endpoint: String, headers: [String : String]?, authType: AuthType, fileName: String, completion: @escaping RemoteCompletionTypeAlias<Response>) where Response : Decodable, Response : Encodable {
        executeClosure(completion, with: retrieveResponse(forMethod: .get, endpoint: endpoint, parameters: nil))
    }
}

private extension MockRemoteManager {
    private func computeKey(using endpoint: String, and parameters: Codable?) -> String {
        var key = endpoint
        let parsedParameters = parameters?.dictionary?.map { $0.key + "=" + "\($0.value)" }.sorted().joined(separator: "&")
        if !self.ignoreParametersInKeys, let parsedParameters = parsedParameters, !parsedParameters.isEmpty {
            key += "?\(parsedParameters)"
        }
        return key
    }

    private func retrieveResponse(forMethod method: HttpMethod, endpoint: String, parameters: Codable?) -> Result<Codable, BaseError> {
        if let response = self.responses[method]?[computeKey(using: endpoint, and: parameters)] {
            return response
        } else {
            return .failure(.repositoryError(.noResponseData))
        }
    }

    private func executeClosure<Response: Codable>(_ closure: @escaping RemoteCompletionTypeAlias<Response>, with response: Result<Codable, BaseError>) {
        switch response {
        case .success(let value):
            if let value = value as? Response {
                closure(.success(value))
            } else {
                closure(.failure(.repositoryError(.reason("Unexpected data type"))))
            }
        case .failure(let error):
            closure(.failure(error))
        }
    }
}


