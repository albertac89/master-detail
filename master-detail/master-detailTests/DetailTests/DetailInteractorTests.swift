//
//  DetailInteractorTests.swift
//  master-detailTests
//
//  Created by Aige Cortasa, Albert on 16/09/2021.
//

import Foundation
import XCTest
@testable import master_detail

class DetailInteractorTests: XCTestCase {
    var sut: DetailInteractor!
    var dataManager: DetailDataManagerMock!
    let postMock = Post(userId: 1,
                    id: 1,
                    title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                    body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum")
    
    override func setUp() {
        super.setUp()
        dataManager = DetailDataManagerMock()

        sut = DetailInteractor(post: postMock, dataManager: dataManager)
    }
    
    func testGetCommentsForPost() {
        XCTAssertFalse(dataManager.getCommentsForPostIsCalled)
        sut.getCommentsForPost { (result: Result<[PostDetailSections], Error>) in
            if case .success(let postDetailSections) = result {
                XCTAssertTrue(postDetailSections.count == 7)
            }
        }
        XCTAssertTrue(dataManager.getCommentsForPostIsCalled)
    }
    
    func testAddCommentForPost() {
        let newComment = "newComment"
        sut.getCommentsForPost { (result: Result<[PostDetailSections], Error>) in }
        sut.addCommentForPost(body: newComment) { (result: Result<[PostDetailSections], Error>) in
            if case .success(let postDetailSections) = result {
                XCTAssertTrue(postDetailSections.count == 8)
                if case .comment(let comment) = postDetailSections[6] {
                    XCTAssertEqual(comment.postId, self.postMock.id)
                    XCTAssertEqual(comment.id, 6)
                    XCTAssertEqual(comment.name, "unknown")
                    XCTAssertEqual(comment.email, "unknown@gmail.com")
                    XCTAssertEqual(comment.body, newComment)
                } else {
                    XCTFail("Expected non-nil comment")
                }
            } else {
                XCTFail("Expected non-nil postDetailSections")
            }
        }
    }
}
