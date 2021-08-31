//
//  AppCoordinator.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator<Void> {

    // MARK: Properties

    private let window: UIWindow

    // MARK: - Initialization

    init(window: UIWindow, navigationController: UINavigationControllerType) {
        self.window = window

        super.init(navigationController: navigationController)
    }

    // MARK: - Override methods

    override func start() -> Observable<Void> {
        guard let rootViewController = navigationController as? UIViewController else { return .never() }

        let coordinator = RequestAddressCoordinator(navigationController: navigationController)

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        return coordinate(to: coordinator)
    }
}
