//
//  DateComponentsFormatter+Extension.swift
//  Bored
//
//  Created by Thiago Centurion on 01/09/21.
//

import Foundation

extension DateComponentsFormatter {

    static var timeSpentFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.calendar = .current
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .short
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute]

        return formatter
    }
}
