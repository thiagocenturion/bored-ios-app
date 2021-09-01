//
//  ActivityFilter.swift
//  Bored
//
// Created by Thiago Centurion on 31/08/21.
//

import Foundation

struct ActivityFilter {

    // MARK: Properties
    var key: String?
    var type: Activity.CategoryType?
    var participants: Int?
    var price: Double?
    var priceRange: ClosedRange<Double>?
    var accessibility: Float?
    var accessibilityRange: ClosedRange<Float>?

    // MARK: - Initialization
    init(key: String? = nil,
         type: Activity.CategoryType? = nil,
         participants: Int? = nil,
         price: Double? = nil,
         priceRange: ClosedRange<Double>? = nil,
         accessibility: Float? = nil,
         accessibilityRange: ClosedRange<Float>? = nil) {

        self.key = key
        self.type = type
        self.participants = participants
        self.price = price
        self.priceRange = priceRange
        self.accessibility = accessibility
        self.accessibilityRange = accessibilityRange
    }
}
