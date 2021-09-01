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
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!

    // MARK: Properties
    private let viewModel: NewActivityViewModel
    private let disposeBag = DisposeBag()

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
        filterButton.rx.tap
            .bind(to: viewModel.openFilter)
            .disposed(by: disposeBag)

        reloadButton.rx.tap
            .bind(to: viewModel.reloadActivity)
            .disposed(by: disposeBag)
    }
}
