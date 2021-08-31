//
//  Activity.swift
//  Bored
//
//  Created by MACBOOK on 30/08/21.
//

import Foundation

struct Activity: Decodable {

    let activity: String
    let accessibility: Float
    let type: ActivityType
    let participants: Int
    let price: Double
    let link: URL
    let key: String
}
