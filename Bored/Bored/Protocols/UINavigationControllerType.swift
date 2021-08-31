//
//  UINavigationControllerType.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import UIKit
import RxSwift

protocol UINavigationControllerType: UIViewControllerType {

    var alert: Binder<AlertViewModel> { get }
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool) -> UIViewController?
}

extension UINavigationController: UINavigationControllerType {

    var alert: Binder<AlertViewModel> { rx.alert }
}
