//
//  APIClientSpy.swift
//  BoredTests
//
//  Created by Thiago Centurion on 31/08/21.
//

import Foundation
import SwiftyJSON
import RxSwift

@testable import Bored

final class APIClientSpy: APIClientProtocol {

    var session: URLSession = .shared
    var requestCalls: [APIRequestType] = []
}

// MARK: - APIClientProtocol
extension APIClientSpy {

    func request(with request: APIRequestType) -> Single<JSON> {
        requestCalls.append(request)
        return .never()
    }
}
