//
//  APIClientStub.swift
//  BoredTests
//
//  Created by Thiago Centurion on 31/08/21.
//

import Foundation
import SwiftyJSON
import RxSwift

@testable import Bored

final class APIClientStub: APIClientProtocol {

    var session: URLSession = .shared
    var requestResponse: Single<JSON> = .just(.init(arrayLiteral: []))
}

// MARK: - APIClientProtocol
extension APIClientStub {

    func request(with request: APIRequestType) -> Single<JSON> {
        return requestResponse
    }
}
