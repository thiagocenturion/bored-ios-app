# iOS Bored App
> Bored is an App which make suggestions of activities in bored moments.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

API https://www.boredapi.com ([Documentation](https://www.boredapi.com/documentation))

## Features

- [x] Reactive programming with [RxSwift](https://github.com/ReactiveX/RxSwift).
- [x] MVVM with reactive Coordinator pattern.
- [x] Reactive and componentized API services layer.
- [x] Unit tested modules with [Quick](https://github.com/Quick/Quick) & [Nimble](https://github.com/Quick/Nimble).
- [x] SOLID, Independency Injection, Stubs and Mocks.
- [x] JSON parses with [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON).

## Run Sample 
1. Clone this repository.
    ```
    git clone https://github.com/thiagocenturion/bored-ios-app.git
    ```
2. Open Terminal and run `pod install`.
3. Wait for the instalation.
4. Open `Bored.xcworkspace`.

## Requirements

- iOS 14.5+
- Xcode 12.5

## Architecture Pattern
The architecture pattern for this application is MVVM with reactive Coordinator, using [RxSwift](https://github.com/ReactiveX/RxSwift).

## Unit Tests
This project tests almost all MVVM-C layers. For that, it was necessary to create Stub and Spy of UIKit native classes, such as `UIViewController` and `UINavigationController` using protocols.

## Project Navigator
Project Navigator for app target and unit test target:

[<img src="/Images/project_navigator_app.png" align="center" width="250" hspace="0" vspace="10">](/Images/project_navigator_app.png)
[<img src="/Images/project_navigator_tests.png" align="center" width="250" hspace="0" vspace="10">](/Images/project_navigator_tests.png)

## Technical Debts
* We still need to create the unit tests for screens `NewActivity`, `ListActivities` and `FilterActivities`. 

## Meta

Thiago Centurion – thiagocenturion@me.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/thiagocenturion/github-link](https://github.com/thiagocenturion/)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
