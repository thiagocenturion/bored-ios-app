//
//  AlertActionViewModel.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import UIKit
import RxRelay

final class AlertActionViewModel {

    // MARK:  Properties

    let title: String?
    let tap = PublishRelay<Void>()

    // MARK: -  Initialization

    init(title: String?) {
        self.title = title
    }
}
