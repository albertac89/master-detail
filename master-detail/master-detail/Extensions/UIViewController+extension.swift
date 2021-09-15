//
//  UIViewController+extension.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 15/09/2021.
//

import UIKit

extension UIViewController {
    func startActivityIndicator() {
        let activityIndicator = ActivityIndicatorScreen()
        activityIndicator.spinner.color = .systemPink
        addChild(activityIndicator)
        activityIndicator.view.frame = view.frame
        view.addSubview(activityIndicator.view)
        activityIndicator.didMove(toParent: self)
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            for child in self.children {
                if child is ActivityIndicatorScreen {
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                }
            }
        }
    }
}
