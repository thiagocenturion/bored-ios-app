//
//  UIViewControllerType.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import UIKit

protocol UIViewControllerType: AnyObject {
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension UIViewController: UIViewControllerType {}
