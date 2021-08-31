//
//  ActivityIndicatorViewController.swift
//  Bored
//
//  Created by Thiago Centurion on 30/08/21.
//

import UIKit

final class ActivityIndicatorViewController: UIViewController {

    private let loading = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)

        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        view.addSubview(loading)

        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
