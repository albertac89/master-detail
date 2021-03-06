//
//  MainViewControllerProtocol.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation

protocol MainViewControllerProtocol: class {
    func setupData(posts: [Post])
    func showMessage(title: String, message: String)
    func startActivityIndicator()
    func stopActivityIndicator()
}
