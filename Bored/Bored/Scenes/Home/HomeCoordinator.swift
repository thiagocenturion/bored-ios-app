//
//  HomeCoordinator.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeCoordinator: BaseCoordinator<Void> {

    // MARK: - Override methods
    override func start() -> Observable<Void> {
        let viewModel = HomeViewModel()

        viewModel.openNewActivity
            .bind(to: startNewActivityScene)
            .disposed(by: disposeBag)

        viewModel.openListActivities
            .bind(to: startListActivitiesScene)
            .disposed(by: disposeBag)

        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)

        return Observable.never()
    }
}

// MARK: - Routing
extension HomeCoordinator {

    private var startNewActivityScene: Binder<Void> {
        return Binder(self) { target, _ in

            let coordinator = NewActivityCoordinator(navigationController: target.navigationController)

            target.coordinate(to: coordinator)
                .subscribe()
                .disposed(by: target.disposeBag)
        }
    }

    private var startListActivitiesScene: Binder<Void> {
        return Binder(self) { target, _ in

            // TODO: Open new activity scene
        }
    }
}
