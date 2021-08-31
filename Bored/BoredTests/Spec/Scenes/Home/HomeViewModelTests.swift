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

                    let title = "Home"
                    let newActivityText = "+ New Activity"
                    let listActivitiesText = "Activities"

                    let viewModel = HomeViewModel(
                        title: title,
                        newActivityText: newActivityText,
                        listActivitiesText: listActivitiesText
                    )

                    expect(viewModel.title) == title
                    expect(viewModel.newActivityText) == newActivityText
                    expect(viewModel.listActivitiesText) == listActivitiesText
                }
            }
        }
    }
}
