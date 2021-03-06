//
//  NetworkingError.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import Foundation

enum NetworkingError: Error {
    /// Device is not connect to thet internet
    case noConnection

    /// Enconding issue when trying to send data.
    case invalidEncode

    /// No data received from the server.
    case noData

    /// Response is not NSHTTPURLResponse
    case nonHTTPResponse(response: URLResponse)

    /// The server response was invalid (unexpected format).
    case invalidDecode

    /// The request was rejected: 400-499.
    case badRequest(error: Error)

    /// Encounted a server error.
    case serverError(error: Error)

    case serverErrorMessage(message: String?)

    /// There was an error parsing the data.
    case parseError(error: Error)

    case unknown

    var rawValue: String {
        switch self {
        case .noConnection:
            return "error_message_no_connection".localized
        case .badRequest:
            return "error_message_bad_request".localized
        case .invalidEncode, .noData, .nonHTTPResponse, .invalidDecode, .serverError, .serverErrorMessage, .parseError, .unknown:
            return "error_message_generic".localized
        }
    }
}

// MARK: - Equatable
extension NetworkingError: Equatable {
    static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.noConnection, .noConnection),
             (.invalidEncode, .invalidEncode),
             (.noData, .noData),
             (.invalidDecode, .invalidDecode),
             (.unknown, .unknown):
            return true
        case (nonHTTPResponse(let lhsResponse), nonHTTPResponse(let rhsResponse)):
            return lhsResponse == rhsResponse
        case (badRequest(let lhsError), badRequest(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (serverError(let lhsError), serverError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (serverErrorMessage(let lhsMessage), serverErrorMessage(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (parseError(let lhsError), parseError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
