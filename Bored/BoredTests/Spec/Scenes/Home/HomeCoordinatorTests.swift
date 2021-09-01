//
//  HomeCoordinatorTests.swift
//  BoredTests
//
//  Created by Thiago Centurion on 31/08/21.
//

import Foundation
import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import Bored

final class HomeCoordinatorTests: QuickSpec {

    override func spec() {

        describe("HomeCoordinator") {

            describe("init") {

                it("initialize with correct parameters") {

                    let navigationController = UINavigationControllerSpy()
                    let coordinator = HomeCoordinator(navigationController: navigationController)

                    expect(coordinator.navigationController) === navigationController
                }
            }

            describe("start") {

                it("pushes the correctly view controller") {

                    let navigationControllerStub = UINavigationControllerSpy()
                    let coordinator = HomeCoordinator(navigationController: navigationControllerStub)

                    expect(navigationControllerStub.pushCalls.isEmpty) == true

                    _ = coordinator.start()

                    expect(navigationControllerStub.pushCalls.count) == 1

                    let pushCall = navigationControllerStub.pushCalls[0]
                    expect(pushCall.viewController is HomeViewController) == true
                    expect(pushCall.animated) == true
                }
            }
        }
    }
}
