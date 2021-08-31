//
//  UIViewController+Rx.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {

    var viewWillAppear: ControlEvent<Bool> {
        let event = methodInvoked(#selector(Base.viewWillAppear)).map { args in (args.first as? Bool) ?? false }
        return ControlEvent(events: event)
    }

    var viewDidAppear: ControlEvent<Bool> {
        let event = methodInvoked(#selector(Base.viewDidAppear)).map { args in (args.first as? Bool) ?? false }
        return ControlEvent(events: event)
    }

    var viewWillDisappear: ControlEvent<Bool> {
        let event = methodInvoked(#selector(Base.viewWillDisappear)).map { args in (args.first as? Bool) ?? false }
        return ControlEvent(events: event)
    }

    var viewDidDisappear: ControlEvent<Bool> {
        let event = methodInvoked(#selector(Base.viewDidDisappear)).map { args in (args.first as? Bool) ?? false }
        return ControlEvent(events: event)
    }
}
