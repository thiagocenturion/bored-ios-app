//
//  ActivityServicesTests.swift
//  BoredTests
//
//  Created by Thiago Centurion on 31/08/21.
//

import Foundation
import Quick
import Nimble
import SwiftyJSON
import RxSwift
import RxCocoa

@testable import Bored

final class ActivityServicesTests: QuickSpec {

    let disposeBag = DisposeBag()

    override func spec() {

        describe("ActivityServices") {

            describe("init") {

                it("initialize with correct parameters") {

                    let apiClient: APIClientProtocol = APIClient(session: .shared)

                    let activityServices = ActivityServices(apiClient: apiClient)

                    expect(activityServices.apiClient) === apiClient
                }
            }

            describe("requestActivity") {

                describe("response") {

                    context("success") {

                        it("should returns activity correctly decoded") {

                            let json = JSON([
                                "activity": "Memorize a favorite quote or poem",
                                "type": "education",
                                "participants": 1,
                                "price": 0,
                                "link": "",
                                "key": "9008639",
                                "accessibility": 0.8
                            ])
                            let apiClientStub = APIClientStub()
                            apiClientStub.requestResponse = .just(json)
                            let activityServices = ActivityServices(apiClient: apiClientStub)

                            let expectedActivity = Activity(
                                title: json["activity"].stringValue,
                                accessibility: json["accessibility"].floatValue,
                                type: Activity.CategoryType(rawValue: json["type"].stringValue)!,
                                participants: json["participants"].intValue,
                                price: json["price"].doubleValue,
                                link: URL(string: json["link"].stringValue),
                                key: json["key"].stringValue,
                                initialTime: nil,
                                status: .none)

                            activityServices.requestActivity(with: ActivityFilter())
                                .subscribe { result in
                                    expect({ () -> ToSucceedResult in
                                        switch result {
                                        case .success(let activity):
                                            expect(activity) == expectedActivity
                                            return .succeeded
                                        case .failure:
                                            return .failed(reason: "Expecting success")
                                        }
                                    }).to(succeed())
                                }.disposed(by: self.disposeBag)
                        }
                    }

                    context("invalid json") {

                        it("should returns invalid decode error") {

                            let json = JSON(["foo": "123"])
                            let apiClientStub = APIClientStub()
                            apiClientStub.requestResponse = .just(json)
                            let activityServices = ActivityServices(apiClient: apiClientStub)

                            activityServices.requestActivity(with: ActivityFilter())
                                .subscribe { result in
                                    expect({ () -> ToSucceedResult in
                                        switch result {
                                        case .success:
                                            return .failed(reason: "Expecting success")
                                        case .failure(let error):
                                            expect(error as? NetworkingError) == .invalidDecode
                                            return .succeeded
                                        }
                                    }).to(succeed())
                                }.disposed(by: self.disposeBag)
                        }
                    }
                }

                describe("request") {

                    context("Empty filter") {

                        it ("should builds an endpoint with no parameters") {

                            let apiClientSpy = APIClientSpy()
                            let activityServices = ActivityServices(apiClient: apiClientSpy)

                            expect(apiClientSpy.requestCalls.isEmpty) == true

                            _ = activityServices.requestActivity(with: .init())

                            expect(apiClientSpy.requestCalls.count) == 1

                            let call = apiClientSpy.requestCalls[0]

                            expect(call.endpoint.path) == "activity"
                            expect(call.endpoint.queryItems) == []
                            expect(call.httpMethod) == .get
                            expect(call.timeout) == 60.0
                        }
                    }

                    context("Filter with key") {

                        it ("should builds an endpoint with key on parameters") {

                            let apiClientSpy = APIClientSpy()
                            let activityServices = ActivityServices(apiClient: apiClientSpy)

                            expect(apiClientSpy.requestCalls.isEmpty) == true

                            let expectedKey = "9660022"
                            _ = activityServices.requestActivity(with: .init(key: expectedKey))

                            expect(apiClientSpy.requestCalls.count) == 1

                            let call = apiClientSpy.requestCalls[0]

                            expect(call.endpoint.path) == "activity"
                            expect(call.endpoint.queryItems) == [.init(name: "key", value: expectedKey)]

                            expect(call.httpMethod) == .get
                            expect(call.timeout) == 60.0
                        }
                    }

                    context("Filter with type") {

                        it ("should builds an endpoint with type on parameters") {

                            let apiClientSpy = APIClientSpy()
                            let activityServices = ActivityServices(apiClient: apiClientSpy)

                            expect(apiClientSpy.requestCalls.isEmpty) == true

                            let expectedType = Activity.CategoryType.recreational
                            _ = activityServices.requestActivity(with: .init(type: expectedType))

                            expect(apiClientSpy.requestCalls.count) == 1

                            let call = apiClientSpy.requestCalls[0]

                            expect(call.endpoint.path) == "activity"
                            expect(call.endpoint.queryItems) == [.init(name: "type", value: expectedType.rawValue)]

                            expect(call.httpMethod) == .get
                            expect(call.timeout) == 60.0
                        }
                    }

                    context("Filter with participants") {

                        it ("should builds an endpoint with participants on parameters") {

                            let apiClientSpy = APIClientSpy()
                            let activityServices = ActivityServices(apiClient: apiClientSpy)

                            expect(apiClientSpy.requestCalls.isEmpty) == true

                            let expectedParticipants = 2
                            _ = activityServices.requestActivity(with: .init(participants: expectedParticipants))

                            expect(apiClientSpy.requestCalls.count) == 1

                            let call = apiClientSpy.requestCalls[0]

                            expect(call.endpoint.path) == "activity"
                            expect(call.endpoint.queryItems) == [.init(name: "participants", value: "\(expectedParticipants)")]

                            expect(call.httpMethod) == .get
                            expect(call.timeout) == 60.0
                        }
                    }

                    context("Filter with price") {

                        it ("should builds an endpoint with price on parameters") {

                            let apiClientSpy = APIClientSpy()
                            let activityServices = ActivityServices(apiClient: apiClientSpy)

                            expect(apiClientSpy.requestCalls.isEmpty) == true

                            let expectedPrice = 0.99
                            _ = activityServices.requestActivity(with: .init(price: expectedPrice))

                            expect(apiClientSpy.requestCalls.count) == 1

                            let call = apiClientSpy.requestCalls[0]

                            expect(call.endpoint.path) == "activity"
                            expect(call.endpoint.queryItems) == [.init(name: "price", value: "\(expectedPrice)")]

                            expect(call.httpMethod) == .get
                            expect(call.timeout) == 60.0
                        }
                    }

                    context("Filter with price range") {

                        it ("should builds an endpoint with price range on parameters") {

                            let apiClientSpy = APIClientSpy()
                            let activityServices = ActivityServices(apiClient: apiClientSpy)

                            expect(apiClientSpy.requestCalls.isEmpty) == true

                            let expectedPriceRange: ClosedRange<Double> = 0.0...0.99
                            _ = activityServices.requestActivity(with: .init(priceRange: expectedPriceRange))

                            expect(apiClientSpy.requestCalls.count) == 1

                            let call = apiClientSpy.requestCalls[0]

                            expect(call.endpoint.path) == "activity"
                            expect(call.endpoint.queryItems) == [
                                .init(name: "minprice", value: "\(expectedPriceRange.lowerBound)"),
                                .init(name: "maxprice", value: "\(expectedPriceRange.upperBound)")
                            ]

                            expect(call.httpMethod) == .get
                            expect(call.timeout) == 60.0
                        }
                    }

                    context("Filter with accessibility") {

                        it ("should builds an endpoint with accessibility on parameters") {

                            let apiClientSpy = APIClientSpy()
                            let activityServices = ActivityServices(apiClient: apiClientSpy)

                            expect(apiClientSpy.requestCalls.isEmpty) == true

                            let expectedAccessibility: Float = 0.1
                            _ = activityServices.requestActivity(with: .init(accessibility: expectedAccessibility))

                            expect(apiClientSpy.requestCalls.count) == 1

                            let call = apiClientSpy.requestCalls[0]

                            expect(call.endpoint.path) == "activity"
                            expect(call.endpoint.queryItems) == [.init(name: "accessibility", value: "\(expectedAccessibility)")]

                            expect(call.httpMethod) == .get
                            expect(call.timeout) == 60.0
                        }
                    }

                    context("Filter with accessibility range") {

                        it ("should builds an endpoint with accessibility range on parameters") {

                            let apiClientSpy = APIClientSpy()
                            let activityServices = ActivityServices(apiClient: apiClientSpy)

                            expect(apiClientSpy.requestCalls.isEmpty) == true

                            let expectedAccessibilityRange: ClosedRange<Float> = 0.1...0.5
                            _ = activityServices.requestActivity(with: .init(accessibilityRange: expectedAccessibilityRange))

                            expect(apiClientSpy.requestCalls.count) == 1

                            let call = apiClientSpy.requestCalls[0]

                            expect(call.endpoint.path) == "activity"
                            expect(call.endpoint.queryItems) == [
                                .init(name: "minaccessibility", value: "\(expectedAccessibilityRange.lowerBound)"),
                                .init(name: "maxaccessibility", value: "\(expectedAccessibilityRange.upperBound)")
                            ]

                            expect(call.httpMethod) == .get
                            expect(call.timeout) == 60.0
                        }
                    }
                }
            } // requestActivity
        }
    }
}
