//
//  UIViewController+Extensions.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import UIKit

extension UIViewController {

    var currentActivityIndicatorViewController: ActivityIndicatorViewController? {
        return children.reversed().first { $0 is ActivityIndicatorViewController } as? ActivityIndicatorViewController
    }

    func showLoading() {
        guard currentActivityIndicatorViewController == nil else { return }

        let activityIndicatorViewController = ActivityIndicatorViewController()

        addChild(activityIndicatorViewController)
        activityIndicatorViewController.view.frame = view.frame
        view.addSubview(activityIndicatorViewController.view)
        activityIndicatorViewController.didMove(toParent: self)
    }

    func hideLoading() {
        guard let activityIndicatorViewController = currentActivityIndicatorViewController else { return }

        activityIndicatorViewController.willMove(toParent: nil)
        activityIndicatorViewController.view.removeFromSuperview()
        activityIndicatorViewController.removeFromParent()
    }
}
