//
//  URLSession+Rx.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import Foundation
import RxCocoa
import RxSwift

extension Reactive where Base: URLSession {

    func dataTask(with request: URLRequest) -> Single<(response: HTTPURLResponse, data: Data)> {
        return Single.create { single in

            let task = self.base.dataTask(with: request) { data, response, error in
                guard let response = response else {
                    single(.failure(error ?? NetworkingError.unknown))
                    return
                }

                guard let data = data else {
                    single(.failure(NetworkingError.noData))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(NetworkingError.nonHTTPResponse(response: response)))
                    return
                }

                guard 200 ..< 300 ~= httpResponse.statusCode else {
                    single(.failure(NetworkingError.serverErrorMessage(message: String(decoding: data, as: UTF8.self))))
                    return
                }

                single(.success((httpResponse, data)))
            }

            task.resume()

            return Disposables.create(with: task.cancel)
        }
    }
}
