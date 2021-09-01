//
//  NewActivityCoordinator.swift
//  Bored
//
// Created by Thiago Centurion on 31/08/21.
//

import UIKit
import RxSwift
import RxCocoa

final class NewActivityCoordinator: BaseCoordinator<Void> {

    // MARK: - Override methods
    override func start() -> Observable<Void> {
        let viewModel = NewActivityViewModel(
            title: "new_activity_title".localized,
            filterText: "new_activity_filter_button".localized,
            reloadText: "new_activity_reload_button".localized,
            activityServices: ActivityServices(apiClient: APIClient.shared),
            isLoading: false,
            activity: nil,
            filter: ActivityFilter()
        )

        viewModel.alert
            .bind(to: navigationController.alert)
            .disposed(by: disposeBag)

        viewModel.openFilter
            .bind(to: startFilterScene)
            .disposed(by: disposeBag)

        let viewController = NewActivityViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)

        return Observable.never()
    }
}

// MARK: - Routing
extension NewActivityCoordinator {

    private var startFilterScene: Binder<Void> {
        return Binder(self) { target, _ in

            // TODO: Open new filter scene
        }
    }
}
