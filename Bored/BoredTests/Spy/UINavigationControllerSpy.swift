//
//  UINavigationControllerSpy.swift
//  BoredTests
//
//  Created by Thiago Centurion on 31/08/21.
//

import UIKit
import RxSwift

@testable import Bored

final class UINavigationControllerSpy: UINavigationControllerType {

    // MARK: - Stub
    var presentCalls: [PresentCall] = []
    var dismissCalls: [DismissCall] = []
    var pushCalls: [PushCall] = []
    var popCalls: [PopCall] = []
    var calledAlertViewModel: AlertViewModel?

    // MARK: - Initialization

    init() {}

    // MARK: - UINavigationControllerType

    var alert: Binder<AlertViewModel> {
        return Binder(self) { target, alertViewModel in
            target.calledAlertViewModel = alertViewModel
        }
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushCalls.append(.init(
            viewController: viewController, animated: animated
        ))
    }

    func popViewController(animated: Bool) -> UIViewController? {
        popCalls.append(.init(
            animated: animated
        ))
        return nil
    }

    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presentCalls.append(.init(
            viewController: viewController,
            animated: animated,
            completion: completion
        ))
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        dismissCalls.append(.init(
            animated: animated,
            completion: completion
        ))
    }
}

// MARK: - Call
extension UINavigationControllerSpy {

    struct PresentCall {
        let viewController: UIViewController
        let animated: Bool
        let completion: (() -> Void)?
    }

    struct DismissCall {
        let animated: Bool
        let completion: (() -> Void)?
    }

    struct PushCall {
        let viewController: UIViewController
        let animated: Bool
    }

    struct PopCall {
        let animated: Bool
    }
}
