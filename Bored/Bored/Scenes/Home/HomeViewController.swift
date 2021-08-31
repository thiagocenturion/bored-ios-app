//
//  HomeViewController.swift
//  Bored
//
//  Created by MACBOOK on 30/08/21.
//

import UIKit
import RxSwift

final class HomeViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var newActivityButton: UIButton!
    @IBOutlet weak var listActivitiesButton: UIButton!

    // MARK: Properties
    let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()

    // MARK: - Initialization
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel

        super.init(
            nibName: String(describing: HomeViewController.self),
            bundle: Bundle(for: HomeViewController.self)
        )
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - View Lifecycle
extension HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        bind()
    }
}

// MARK: - Private methods
extension HomeViewController {

    private func setup() {
        title = viewModel.title
        newActivityButton.setTitle(viewModel.newActivityText, for: .normal)
        listActivitiesButton.setTitle(viewModel.listActivitiesText, for: .normal)
    }

    private func bind() {
        newActivityButton.rx.tap
            .bind(to: viewModel.openNewActivity)
            .disposed(by: disposeBag)

        listActivitiesButton.rx.tap
            .bind(to: viewModel.openListActivities)
            .disposed(by: disposeBag)
    }
}
