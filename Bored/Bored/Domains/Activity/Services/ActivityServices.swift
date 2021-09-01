//
//  ActivityServices.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import Foundation
import RxSwift
import SwiftyJSON
import CoreLocation

protocol ActivityServicesProtocol {

    var apiClient: APIClientProtocol { get }

    func requestActivity(with filter: ActivityFilter) -> Single<Activity>
}

final class ActivityServices: ActivityServicesProtocol {

    // MARK: Properties
    let apiClient: APIClientProtocol

    // MARK: - Initialization
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: - PlaceWebServicesType
    func requestActivity(with filter: ActivityFilter) -> Single<Activity> {

        var queryItems = [URLQueryItem]()

        if let key = filter.key {
            queryItems.append(.init(name: "key", value: key))
        }

        if let type = filter.type {
            queryItems.append(.init(name: "type", value: type.rawValue))
        }

        if let participants = filter.participants {
            queryItems.append(.init(name: "participants", value: "\(participants)"))
        }

        if let price = filter.price {
            queryItems.append(.init(name: "price", value: "\(price)"))
        }

        if let priceRange = filter.priceRange {
            queryItems.append(.init(name: "minprice", value: "\(priceRange.lowerBound)"))
            queryItems.append(.init(name: "maxprice", value: "\(priceRange.upperBound)"))
        }

        if let accessibility = filter.accessibility {
            queryItems.append(.init(name: "accessibility", value: "\(accessibility)"))
        }

        if let accessibilityRange = filter.accessibilityRange {
            queryItems.append(.init(name: "minaccessibility", value: "\(accessibilityRange.lowerBound)"))
            queryItems.append(.init(name: "maxaccessibility", value: "\(accessibilityRange.upperBound)"))
        }

        let request = APIRequest(
            endpoint: Endpoint(path: "activity", queryItems: queryItems),
            httpMethod: .get,
            timeout: 60.0
        )

        return apiClient.request(with: request).flatMap { json in
            guard
                let activity = try? JSONDecoder().decode(Activity.self, from: json.rawData())
            else {
                return .error(NetworkingError.invalidDecode)
            }

            return .just(activity)
        }
    }
}
