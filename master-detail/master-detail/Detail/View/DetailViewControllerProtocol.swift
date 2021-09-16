//
//  DetailViewControllerProtocol.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 14/09/2021.
//

import Foundation

protocol DetailViewControllerProtocol: class {
    func setupData(sections: [PostDetailSections], scrollBottom: Bool)
    func showMessage(title: String, message: String)
    func startActivityIndicator()
    func stopActivityIndicator()
}
