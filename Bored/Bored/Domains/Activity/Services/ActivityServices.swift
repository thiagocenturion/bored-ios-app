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

protocol PlaceServicesType {

    var apiClient: APIClientType { get }

    func requestActivity(
        key: String?,
        type: ActivityType?,
        participants: Int?,
        price: Double?,
        priceRange: Range<Double>?,
        accessibility: Float?,
        accessibilityRange: Range<Float>?) -> Single<Activity>
}

final class PlaceServices: PlaceServicesType {

    // MARK: Properties
    let apiClient: APIClientType

    // MARK: - Initialization
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }

    // MARK: - PlaceWebServicesType
    func requestActivity(
        key: String? = nil,
        type: ActivityType? = nil,
        participants: Int? = nil,
        price: Double? = nil,
        priceRange: Range<Double>? = nil,
        accessibility: Float? = nil,
        accessibilityRange: Range<Float>? = nil) -> Single<Activity> {

        var queryItems = [URLQueryItem]()

        if let key = key {
            queryItems.append(.init(name: "key", value: key))
        }

        if let type = type {
            queryItems.append(.init(name: "type", value: type.rawValue))
        }

        if let participants = participants {
            queryItems.append(.init(name: "participants", value: "\(participants)"))
        }

        if let price = price {
            queryItems.append(.init(name: "price", value: "\(price)"))
        }

        if let priceRange = priceRange {
            queryItems.append(.init(name: "minprice", value: "\(priceRange.lowerBound)"))
            queryItems.append(.init(name: "maxprice", value: "\(priceRange.upperBound)"))
        }

        if let accessibility = accessibility {
            queryItems.append(.init(name: "accessibility", value: "\(accessibility)"))
        }

        if let accessibilityRange = accessibilityRange {
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
