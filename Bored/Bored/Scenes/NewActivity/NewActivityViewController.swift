//
//  NewActivityViewController.swift
//  Bored
//
//  Created by Thiago Centurion on 31/08/21.
//

import UIKit
import RxSwift

final class NewActivityViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var reloadButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!

    // MARK: Properties
    private let viewModel: NewActivityViewModel
    private var activityCardViewModel: ActivityCardViewModel?
    private let disposeBag = DisposeBag()

    private weak var activityCardView: ActivityCardView?

    // MARK: - Initialization
    init(viewModel: NewActivityViewModel) {
        self.viewModel = viewModel

        super.init(
            nibName: String(describing: NewActivityViewController.self),
            bundle: Bundle(for: NewActivityViewController.self)
        )
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - View Lifecycle
extension NewActivityViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bind()
    }
}

// MARK: - Private methods
extension NewActivityViewController {

    private func setup() {
        title = viewModel.title
        filterButton.setTitle(viewModel.filterText, for: .normal)
        reloadButton.setTitle(viewModel.reloadText, for: .normal)
    }

    private func bind() {

        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.showLoading() : self?.hideLoading()
            })
            .disposed(by: disposeBag)

        viewModel.activity
            .observe(on: MainScheduler.instance)
            .bind(to: updateActivityCardView)
            .disposed(by: disposeBag)

        filterButton.rx.tap
            .bind(to: viewModel.openFilter)
            .disposed(by: disposeBag)

        reloadButton.rx.tap
            .bind(to: viewModel.reloadActivity)
            .disposed(by: disposeBag)
    }

    private func createActivityCardViewIfNeeded(with activity: Activity) {
        if activityCardView == nil {
            let activityCardViewModel = ActivityCardViewModel(activity: activity, calendar: .current)
            self.activityCardViewModel = activityCardViewModel

            let activityCardView = ActivityCardView(viewModel: activityCardViewModel)
            stackView.addArrangedSubview(activityCardView)
            self.activityCardView = activityCardView
        }
    }

    private func removeActivityCardViewIfNeeded() {
        if let activityCardView = activityCardView {
            stackView.removeArrangedSubview(activityCardView)
            activityCardView.removeFromSuperview()

            self.activityCardViewModel = nil
        }
    }
}

// MARK: - Binding
extension NewActivityViewController {

    private var updateActivityCardView: Binder<Activity?> {
        return Binder(self) { target, activity in

            if let activity = activity {
                target.createActivityCardViewIfNeeded(with: activity)
                target.activityCardViewModel?.activity.accept(activity)
            } else {
                target.removeActivityCardViewIfNeeded()
            }
        }
    }
}
