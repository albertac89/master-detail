//
//  MainViewControllerMock.swift
//  master-detailTests
//
//  Created by Aige Cortasa, Albert on 15/09/2021.
//

import Foundation
@testable import master_detail

class MainViewControllerMock: MainViewControllerProtocol {
    var setupDataIsCalled = false
    var showMessageIsCalled = false
    var startActivityIndicatorIsCalled = false
    var stopActivityIndicatorIsCalled = false
    
    func setupData(posts: [Post]) {
        setupDataIsCalled = true
    }
    
    func showMessage(title: String, message: String) {
        showMessageIsCalled = true
    }
    
    func startActivityIndicator() {
        startActivityIndicatorIsCalled = true
    }
    
    func stopActivityIndicator() {
        stopActivityIndicatorIsCalled = true
    }
}
