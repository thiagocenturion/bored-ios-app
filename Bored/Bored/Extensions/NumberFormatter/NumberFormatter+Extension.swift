//
//  NumberFormatter+Extension.swift
//  Bored
//
//  Created by MACBOOK on 01/09/21.
//

import Foundation

extension NumberFormatter {

    static var currencyDollarFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = .init(identifier: "en_US")
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.usesGroupingSeparator = true
        return numberFormatter
    }
}
