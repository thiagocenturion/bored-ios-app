//
//  HomeViewModelTests.swift
//  BoredTests
//
//  Created by Thiago Centurion on 31/08/21.
//

import Foundation
import Nimble
import Quick
import RxCocoa
import RxSwift

@testable import Bored

final class HomeViewModelTests: QuickSpec {

    let disposeBag = DisposeBag()

    override func spec() {

        describe("HomeViewModel") {

            describe("init") {

                it("configures the properties correctly") {

                    let viewModel = HomeViewModel()

                    expect(viewModel.title) == "home_title".localized
                    expect(viewModel.newActivityText) == "home_new_activity_button".localized
                    expect(viewModel.listActivitiesText) == "home_list_activities_button".localized
                }
            }
        }
    }
}
