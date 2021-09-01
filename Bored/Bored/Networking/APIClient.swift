//
//  APIClient.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import Foundation
import SwiftyJSON
import RxCocoa
import RxSwift

protocol APIClientProtocol {
    var session: URLSession { get }

    func request(with request: APIRequestType) -> Single<JSON>
}

final class APIClient: APIClientProtocol {

    // MARK: Shared

    static let shared: APIClientProtocol = APIClient(session: URLSession.shared)

    // MARK: APIClientProtocol

    let session: URLSession

    // MARK: - Initialization

    init(session: URLSession) {
        self.session = session
    }
}

// MARK: - APIClientProtocol
extension APIClient {

    func request(with request: APIRequestType) -> Single<JSON> {

        switch request.urlRequest {
        case .success(let urlRequest):
            return self.session.rx.dataTask(with: urlRequest)
                .flatMap { response, data in
                    guard let json = try? JSON(data: data) else {
                        return .error(NetworkingError.invalidDecode)
                    }

                    return .just(json)
                }

        case .failure(let error):
            return .error(error)
        }
    }
}
