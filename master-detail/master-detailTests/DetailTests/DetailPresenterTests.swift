//
//  DetailPresenterTests.swift
//  master-detailTests
//
//  Created by Aige Cortasa, Albert on 16/09/2021.
//

import Foundation

import XCTest
@testable import master_detail

class DetailPresenterTests: XCTestCase {
    var sut: DetailPresenter!
    var view: DetailViewControllerMock!
    var interactor: DetailInteractorMock!
    
    override func setUp() {
        super.setUp()
        view = DetailViewControllerMock()
        interactor = DetailInteractorMock()
        sut = DetailPresenter(interactor: interactor)
        sut.view = view
    }
    
    func testGetCommentsDetails() {
        XCTAssertFalse(interactor.getCommentsForPostIsCalled)
        XCTAssertFalse(view.setupDataIsCalled)
        XCTAssertFalse(view.startActivityIndicatorIsCalled)
        XCTAssertFalse(view.stopActivityIndicatorIsCalled)
        sut.getCommentsDetails()
        XCTAssertTrue(interactor.getCommentsForPostIsCalled)
        XCTAssertTrue(view.setupDataIsCalled)
        XCTAssertTrue(view.startActivityIndicatorIsCalled)
        XCTAssertTrue(view.stopActivityIndicatorIsCalled)
    }
    
    func testAddComment() {
        XCTAssertFalse(interactor.addCommentForPostIsCalled)
        XCTAssertFalse(view.setupDataIsCalled)
        XCTAssertFalse(view.startActivityIndicatorIsCalled)
        XCTAssertFalse(view.stopActivityIndicatorIsCalled)
        sut.addComment(body: "body")
        XCTAssertTrue(interactor.addCommentForPostIsCalled)
        XCTAssertTrue(view.setupDataIsCalled)
        XCTAssertTrue(view.startActivityIndicatorIsCalled)
        XCTAssertTrue(view.stopActivityIndicatorIsCalled)
    }
}
