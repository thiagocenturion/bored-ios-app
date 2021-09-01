//
//  HomeViewModel.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {

    // MARK: Properties
    let title = "home_title".localized
    let newActivityText = "home_new_activity_button".localized
    let listActivitiesText = "home_list_activities_button".localized

    // MARK: Actions
    let openNewActivity = PublishRelay<Void>()
    let openListActivities = PublishRelay<Void>()

    // MARK: - Initialization
    init() {
    }
}
