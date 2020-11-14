//
//  BaseError.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Foundation

public enum BaseError: Error {
    case repositoryError(RepositoryError)
    case remoteError(RemoteError)
    case socketError(SocketError)
    case authError(AuthError)
    case ui(UIError)

    public enum RepositoryError {
        case noResponseData
        case localStorageUpToDate
        case reason(String)

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            default:
                return String(describing: self)
            }
        }
    }

    public enum RemoteError {
        case httpUrlResponse(HTTPURLResponse)
        case code(Int)
        case reason(String)

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            default:
                return String(describing: self).capitalizingFirstLetter()
            }
        }
    }

    public enum AuthError {
        case generic(Error)
        case mobilePhone
        case reason(String)
        case badURL

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            case let .generic(error):
                return "Generic: \(error.localizedDescription)"
            default:
                return String(describing: self).capitalizingFirstLetter()
            }
        }
    }

    public enum SocketError: Equatable {
        case ackNotFound
        case socketIsDisconnect
        case wrongDataResponse(String)
        case reason(String)
        case sendMessageWrongFormat

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            case let .wrongDataResponse(details):
                return "WrongDataResponse: \(details)"
            default:
                return String(describing: self).capitalizingFirstLetter()
            }
        }
    }

    public enum UIError {
        case cantLoad
        case notResponds
        case notFound
        case reason(String)

        var description: String {
            switch self {
            case let .reason(reason):
                return "Reason: \(reason)"
            default:
                return String(describing: self).capitalizingFirstLetter()
            }
        }
    }

    var description: String {
        switch self {
        case let .repositoryError(error):
            return "RepositoryError - " + error.description
        case let .remoteError(error):
            return "RemoteError - " + error.description
        case let .authError(error):
            return "AuthError - " + error.description
        case let .socketError(error):
            return "SocketError - " + error.description
        case let .ui(error):
            return "UIError - " + error.description
        }
    }
}

extension BaseError: Equatable {
    public static func == (lhs: BaseError, rhs: BaseError) -> Bool {
        return lhs.description == rhs.description
    }
}

private extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

