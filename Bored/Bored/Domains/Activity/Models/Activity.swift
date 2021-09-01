//
//  Activity.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import Foundation

final class Activity: Codable {

    // MARK: Inner types

    enum Status: Int16, Codable {
        case none
        case inProgress
        case done
        case withdrawal
    }

    enum CategoryType: String, Codable {
        case none
        case education
        case recreational
        case social
        case diy
        case charity
        case cooking
        case relaxation
        case music
        case busywork
    }
    
    // MARK: Properties
    let title: String
    let accessibility: Float
    let type: CategoryType
    let participants: Int
    let price: Double
    var link: URL?
    let key: String

    var initialDate: Date?
    let status: Status

    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case title = "activity"
        case accessibility, type, participants, price, link, key, initialDate, status
    }

    // MARK: - Initialization
    init(title: String,
         accessibility: Float,
         type: CategoryType,
         participants: Int,
         price: Double,
         link: URL?,
         key: String,
         initialDate: Date?,
         status: Status) {

        self.title = title
        self.accessibility = accessibility
        self.type = type
        self.participants = participants
        self.price = price
        self.link = link
        self.key = key
        self.initialDate = initialDate
        self.status = status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.title = try container.decode(String.self, forKey: .title)
        self.accessibility = try container.decode(Float.self, forKey: .accessibility)
        self.type = try container.decode(CategoryType.self, forKey: .type)
        self.participants = try container.decode(Int.self, forKey: .participants)
        self.price = try container.decode(Double.self, forKey: .price)

        let linkString = try container.decode(String.self, forKey: .link)

        if let url = URL(string: linkString) {
            self.link = url
        }

        self.key = try container.decode(String.self, forKey: .key)

        if let initialDate = try? container.decode(Date.self, forKey: .initialDate) {
            self.initialDate = initialDate
        }

        let status = try? container.decode(Status.self, forKey: .key)
        self.status = status ?? .none
    }
}
