//
//  AlertViewModel.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import UIKit

final class AlertViewModel {

    // MARK:  Properties

    let title: String?
    let message: String?
    let preferredStyle: UIAlertController.Style
    let actionsViewModels: [AlertActionViewModel]
    let cancelActionViewModel: AlertActionViewModel?

    // MARK: - Initialization

    init(title: String?,
         message: String?,
         preferredStyle: UIAlertController.Style,
         actionsViewModels: [AlertActionViewModel],
         cancelActionViewModel: AlertActionViewModel?) {

        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        self.actionsViewModels = actionsViewModels
        self.cancelActionViewModel = cancelActionViewModel
    }
}
