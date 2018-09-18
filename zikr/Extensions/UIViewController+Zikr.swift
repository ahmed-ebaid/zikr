//
//  UIViewController+Zikr.swift
//  zikr
//
//  Created by Ahmed Ebaid on 6/9/18.
//  Copyright © 2018 Ahmed Ebaid. All rights reserved.
//
import UIKit

extension UIViewController {
    func startActivtyIndicator() {
        let loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
        configureLoadingIndicator(loadingIndicator: loadingIndicator)
        loadingIndicator.startAnimating()
    }

    func stopActivityIndicator() {
        if let currentView = view.subviews.last as? UIActivityIndicatorView {
            currentView.stopAnimating()
            currentView.removeFromSuperview()
        }
    }

    private func configureLoadingIndicator(loadingIndicator: UIActivityIndicatorView) {
        loadingIndicator.center = view.center
        loadingIndicator.color = UIColor.black.withAlphaComponent(0.3)
        view.addSubview(loadingIndicator)
    }
}
