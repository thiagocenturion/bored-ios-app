//
//  ActivityCardView.swift
//  Bored
//
//  Created by Thiago Centurion on 31/08/21.
//

import UIKit
import RxSwift
import RxCocoa

final class ActivityCardView: UIView {

    // MARK: Outlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var difficultyLevelLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var timeSpentLabel: UILabel!
    @IBOutlet private weak var participantsLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var statusAndTimeSpentStackView: UIStackView!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var checkButton: UIButton!
    @IBOutlet private weak var performButton: UIButton!

    // MARK: Properties
    private let viewModel: ActivityCardViewModel
    private let disposeBag = DisposeBag()

    // MARK: - Initialization
    init(viewModel: ActivityCardViewModel) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        Bundle.main.loadNibNamed(String(describing: ActivityCardView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        bind()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - Binding
extension ActivityCardView {

    private func bind() {
        // Hidden views
        viewModel.isStatusAndTimeSpentHidden
            .bind(to: statusAndTimeSpentStackView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.isDeleteButtonHidden
            .bind(to: deleteButton.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.isCheckButtonHidden
            .bind(to: checkButton.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.isPerformButtonHidden
            .bind(to: performButton.rx.isHidden)
            .disposed(by: disposeBag)

        // Labels
        viewModel.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.difficultyLevel
            .bind(to: difficultyLevelLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.category
            .bind(to: categoryLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.status
            .bind(to: statusLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.timeSpent
            .bind(to: timeSpentLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.participants
            .bind(to: participantsLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.price
            .bind(to: priceLabel.rx.text)
            .disposed(by: disposeBag)

        // Buttons
        deleteButton.rx.tap
            .withLatestFrom(viewModel.activity)
            .bind(to: viewModel.deleteDidTap)
            .disposed(by: disposeBag)

        checkButton.rx.tap
            .withLatestFrom(viewModel.activity)
            .bind(to: viewModel.checkDidTap)
            .disposed(by: disposeBag)

        performButton.rx.tap
            .withLatestFrom(viewModel.activity)
            .bind(to: viewModel.performDidTap)
            .disposed(by: disposeBag)
    }
}
