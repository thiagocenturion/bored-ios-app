//
//  NewActivityCoordinator.swift
//  Bored
//
// Created by Thiago Centurion on 31/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

final class NewActivityCoordinator: BaseCoordinator<Void> {

    // MARK: - Override methods
    override func start() -> Observable<Void> {
        let viewModel = NewActivityViewModel(
            activityServices: ActivityServices(apiClient: APIClient.shared),
            activityCoreData: ActivityCoreData(managedContext: NSManagedObjectContext.current),
            isLoading: false,
            activity: nil,
            filter: ActivityFilter()
        )

        viewModel.alert
            .bind(to: navigationController.alert)
            .disposed(by: disposeBag)

        viewModel.filterDidTap
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
