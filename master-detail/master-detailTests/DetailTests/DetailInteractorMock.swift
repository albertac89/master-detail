//
//  DetailInteractorMock.swift
//  master-detailTests
//
//  Created by Aige Cortasa, Albert on 16/09/2021.
//

import Foundation
@testable import master_detail

class DetailInteractorMock: DetailInteractorProtocol {
    var getCommentsForPostIsCalled = false
    var addCommentForPostIsCalled = false
    
    func getCommentsForPost(completion: @escaping (Result<[PostDetailSections], Error>) -> Void) {
        getCommentsForPostIsCalled = true
        var postDetailSectionsMock = [PostDetailSections]()
        postDetailSectionsMock.append(.addComment)
        completion(.success(postDetailSectionsMock))
    }
    
    func addCommentForPost(body: String, completion: @escaping (Result<[PostDetailSections], Error>) -> Void) {
        addCommentForPostIsCalled = true
        var postDetailSectionsMock = [PostDetailSections]()
        postDetailSectionsMock.append(.addComment)
        completion(.success(postDetailSectionsMock))
    }
}
