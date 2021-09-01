//
//  ActivityMock.swift
//  BoredTests
//
//  Created by Thiago Centurion on 31/08/21.
//

import Foundation

@testable import Bored

extension Activity {
    static func mock(title: String = "Memorize a favorite quote or poem",
                     accessibility: Float = 0.8,
                     type: CategoryType = .education,
                     participants: Int = 1,
                     price: Double = 0,
                     link: URL? = URL(string: "https://www.pagat.com"),
                     key: String = "9008639",
                     initialTime: Date? = Date(),
                     status: Status = .none) -> Activity {

        .init(
            title: title,
            accessibility: accessibility,
            type: type,
            participants: participants,
            price: price,
            link: link,
            key: key,
            initialTime: initialTime,
            status: status)
    }
}

// MARK: - Equatable
extension Activity: Equatable {
    public static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.title == rhs.title &&
            lhs.accessibility == rhs.accessibility &&
            lhs.type == rhs.type &&
            lhs.participants == rhs.participants &&
            lhs.price == rhs.price &&
            lhs.link == rhs.link &&
            lhs.key == rhs.key &&
            lhs.initialDate == rhs.initialDate &&
            lhs.status == rhs.status
    }
}
