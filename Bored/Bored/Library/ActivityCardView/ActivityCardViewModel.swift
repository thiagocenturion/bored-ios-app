//
//  ActivityCardViewModel.swift
//  Bored
//
//  Created by Thiago Centurion on 01/09/21.
//

import Foundation
import RxSwift
import RxCocoa

final class ActivityCardViewModel {

    // MARK: Properties
    let activity: BehaviorRelay<Activity>

    private let disposeBag = DisposeBag()
    private let calendar: Calendar

    // MARK: States
    let title = PublishRelay<String>()
    let difficultyLevel = PublishRelay<String>()
    let category = PublishRelay<String>()
    let status = PublishRelay<String>()
    let timeSpent = PublishRelay<String>()
    let participants = PublishRelay<String>()
    let price = PublishRelay<String>()

    let isStatusAndTimeSpentHidden = BehaviorRelay<Bool>(value: true)
    let isDeleteButtonHidden = BehaviorRelay<Bool>(value: true)
    let isCheckButtonHidden = BehaviorRelay<Bool>(value: true)
    let isPerformButtonHidden = BehaviorRelay<Bool>(value: true)

    // MARK: Actions
    let deleteDidTap = PublishRelay<Void>()
    let checkDidTap = PublishRelay<Void>()
    let performDidTap = PublishRelay<Void>()

    // MARK: - Initialization
    init(activity: Activity, calendar: Calendar) {
        self.activity = .init(value: activity)
        self.calendar = calendar

        bind()
    }
}

// MARK: - Binding
extension ActivityCardViewModel {

    private func bind() {
        activity.map(\.title)
            .bind(to: title)
            .disposed(by: disposeBag)

        activity.map(\.accessibility)
            .map { "\($0 * 100)%" }
            .bind(to: difficultyLevel)
            .disposed(by: disposeBag)

        activity.map(\.type)
            .map { $0.rawValue.capitalized }
            .bind(to: category)
            .disposed(by: disposeBag)

        activity.map(\.status)
            .compactMap(statusText(with:))
            .bind(to: status)
            .disposed(by: disposeBag)

        activity.map(\.initialTime)
            .compactMap(timeSpentText(with:))
            .bind(to: timeSpent)
            .disposed(by: disposeBag)

        activity.map(\.participants)
            .map { "\($0)" }
            .bind(to: participants)
            .disposed(by: disposeBag)

        activity.map(\.price)
            .compactMap(priceText(with:))
            .bind(to: price)
            .disposed(by: disposeBag)

        // Status presentation logic
        activity.map(\.status)
            .compactMap(shouldHideStatusAndTimeSpent(with:))
            .bind(to: isStatusAndTimeSpentHidden)
            .disposed(by: disposeBag)

        activity.map(\.status)
            .compactMap(shouldHideDeleteButton(with:))
            .bind(to: isDeleteButtonHidden)
            .disposed(by: disposeBag)

        activity.map(\.status)
            .compactMap(shouldHideCheckButton(with:))
            .bind(to: isCheckButtonHidden)
            .disposed(by: disposeBag)

        activity.map(\.status)
            .compactMap(shouldHidePerformButton(with:))
            .bind(to: isPerformButtonHidden)
            .disposed(by: disposeBag)
    }
}

// MARK: - Private methods
extension ActivityCardViewModel {

    private func statusText(with status: Activity.Status) -> String {
        switch status {
        case .none: return "activity_status_none".localized
        case .inProgress: return "activity_status_inprogress".localized
        case .done: return "activity_status_done".localized
        case .withdrawal: return "activity_status_withdrawal".localized
        }
    }

    private func timeSpentText(with initialDate: Date?) -> String? {
        if let initialDate = initialDate {
            let components: Set<Calendar.Component> = [.minute, .hour, .day, .month, .year]
            let difference = calendar.dateComponents(components, from: initialDate, to: Date())

            if let year = difference.year, year > 0 {
                if year == 1 {
                    return "\(year)" + "timespent_year".localized
                } else {
                    return "\(year)" + "timespent_years".localized
                }
            } else if let month = difference.month, month > 0 {
                if month == 1 {
                    return "\(month)" + "timespent_month".localized
                } else {
                    return "\(month)" + "timespent_months".localized
                }
            } else if let day = difference.day, day > 0 {
                if day == 1 {
                    return "\(day)" + "timespent_day".localized
                } else {
                    return "\(day)" + "timespent_days".localized
                }
            } else if let minute = difference.minute, minute > 0 {
                if minute == 1 {
                    return "\(minute)" + "timespent_minute".localized
                } else {
                    return "\(minute)" + "timespent_minutes".localized
                }
            } else {
                return "timestamp_now".localized
            }
        } else {
            return nil
        }
    }

    private func priceText(with price: Double) -> String? {
        if price == 0 {
            return "price_free".localized
        } else {
            return NumberFormatter.currencyDollarFormatter.string(from: NSNumber(value: price))
        }
    }

    private func shouldHideStatusAndTimeSpent(with status: Activity.Status) -> Bool {
        switch status {
        case .none:
            return true
        case .inProgress, .done, .withdrawal:
            return false
        }
    }

    private func shouldHideDeleteButton(with status: Activity.Status) -> Bool {
        switch status {
        case .none, .done, .withdrawal:
            return true
        case .inProgress:
            return false
        }
    }

    private func shouldHideCheckButton(with status: Activity.Status) -> Bool {
        switch status {
        case .none, .done, .withdrawal:
            return true
        case .inProgress:
            return false
        }
    }

    private func shouldHidePerformButton(with status: Activity.Status) -> Bool {
        switch status {
        case .none:
            return false
        case .inProgress, .done, .withdrawal:
            return true
        }
    }
}
