//
//  MainRouterMock.swift
//  master-detailTests
//
//  Created by Aige Cortasa, Albert on 15/09/2021.
//

import Foundation
@testable import master_detail

class MainRouterMock: MainRouterProtocol {
    var openDetialIsCalled = false
    
    func openDetail(post: Post) {
        openDetialIsCalled = true
    }
}
