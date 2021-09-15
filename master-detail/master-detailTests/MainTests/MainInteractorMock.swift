//
//  MainInteractorMock.swift
//  master-detailTests
//
//  Created by Aige Cortasa, Albert on 15/09/2021.
//

import Foundation
@testable import master_detail

class MainInteractorMock: MainInteractorProtocol {
    var getPostsIsCalled = false
    
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        getPostsIsCalled = true
        completion(.success([Post(userId: 0, id: 0, title: "title", body: "body")]))
    }
}
