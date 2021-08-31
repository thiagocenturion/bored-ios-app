//
//  HomeViewModel.swift
//  Bored
//
//  Created by MACBOOK on 30/08/21.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {

    // MARK: Properties
    let title: String
    let newActivityText: String
    let listActivitiesText: String

    private let disposeBag = DisposeBag()

    // MARK: Actions
    let openNewActivity = PublishRelay<Void>()
    let openListActivities = PublishRelay<Void>()

    // MARK: - Initialization
    init(title: String,
         newActivityText: String,
         listActivitiesText: String) {
        self.title = title
        self.newActivityText = newActivityText
        self.listActivitiesText = listActivitiesText

        bind()
    }
}

// MARK: - Binding
extension HomeViewModel {

    private func bind() {
        // TODO: Core Data
    }
}
