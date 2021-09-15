//
//  MainPresenterTests.swift
//  master-detailTests
//
//  Created by Aige Cortasa, Albert on 15/09/2021.
//

import Foundation

import XCTest
@testable import master_detail

class MainPresenterTests: XCTestCase {
    var sut: MainPresenter!
    var view: MainViewControllerMock!
    var router: MainRouterMock!
    var interactor: MainInteractorMock!
    var networkMonitor: NetworkMonitor!
    
    override func setUp() {
        super.setUp()
        view = MainViewControllerMock()
        router = MainRouterMock()
        interactor = MainInteractorMock()
        networkMonitor = NetworkMonitor.shared
        networkMonitor.isNetworkAvailable = true
        sut = MainPresenter(interactor: interactor, router: router, networkMonitor: networkMonitor)
        sut.view = view
    }
    
    func testGetPosts() {
        XCTAssertFalse(interactor.getPostsIsCalled)
        XCTAssertFalse(view.setupDataIsCalled)
        XCTAssertFalse(view.showMessageIsCalled)
        XCTAssertFalse(view.startActivityIndicatorIsCalled)
        XCTAssertFalse(view.stopActivityIndicatorIsCalled)
        sut.getPosts()
        XCTAssertTrue(interactor.getPostsIsCalled)
        XCTAssertTrue(view.setupDataIsCalled)
        XCTAssertFalse(view.showMessageIsCalled)
        XCTAssertTrue(view.startActivityIndicatorIsCalled)
        XCTAssertTrue(view.stopActivityIndicatorIsCalled)
    }
    
    func testOpenDetail() {
        XCTAssertFalse(view.showMessageIsCalled)
        XCTAssertFalse(router.openDetialIsCalled)
        sut.openDetail(post: Post(userId: 0, id: 0, title: "title", body: "body"))
        XCTAssertFalse(view.showMessageIsCalled)
        XCTAssertTrue(router.openDetialIsCalled)
    }
}
