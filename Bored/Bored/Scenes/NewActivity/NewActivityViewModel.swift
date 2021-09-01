//
//  NewActivityViewModel.swift
//  Bored
//
// Created by Thiago Centurion on 31/08/21.
//

import Foundation
import RxSwift
import RxCocoa

final class NewActivityViewModel {

    // MARK: Properties
    let title: String
    let filterText: String
    let reloadText: String
    let activityServices: ActivityServicesProtocol

    private let disposeBag = DisposeBag()

    // MARK: Behaviors
    let isLoading: BehaviorRelay<Bool>
    let activity: BehaviorRelay<Activity?>
    let filter: BehaviorRelay<ActivityFilter>

    // MARK: Actions
    let alert = PublishRelay<AlertViewModel>()
    let openFilter = PublishRelay<Void>()
    let reloadActivity = PublishRelay<Void>()

    // MARK: - Initialization
    init(title: String,
         filterText: String,
         reloadText: String,
         activityServices: ActivityServicesProtocol,
         isLoading: Bool,
         activity: Activity?,
         filter: ActivityFilter) {

        self.title = title
        self.filterText = filterText
        self.reloadText = reloadText
        self.activityServices = activityServices

        self.isLoading = .init(value: isLoading)
        self.activity = .init(value: activity)
        self.filter = .init(value: filter)

        bind()
    }
}

// MARK: - Binding
extension NewActivityViewModel {

    private func bind() {
        reloadActivity
            .withLatestFrom(filter)
            .bind(to: fetchNewActivity)
            .disposed(by: disposeBag)
    }
}

// MARK: - Networking
extension NewActivityViewModel {

    private var fetchNewActivity: Binder<ActivityFilter> {
        return Binder(self) { target, filter in
            target.activityServices.requestActivity(with: filter)
            .do(onSubscribe: { target.isLoading.accept(true) })
            .do(onDispose: { target.isLoading.accept(false) })
            .subscribe(
                onSuccess: { activity in
                    target.activity.accept(activity)
                },
                onFailure: { error in
                    guard let networkingError = error as? NetworkingError else { return }
                    let alertViewModel = AlertViewModel(
                        title: "error_message_title".localized,
                        message: networkingError.rawValue,
                        preferredStyle: .alert,
                        actionsViewModels: [.init(title: "error_message_confirm_button".localized)],
                        cancelActionViewModel: .init(title: "request_address_denied_cancel".localized)
                    )
                    target.alert.accept(alertViewModel)
                }
            ).disposed(by: target.disposeBag)
        }
    }
}
