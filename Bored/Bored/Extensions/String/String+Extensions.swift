//
//  String+Extensions.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
