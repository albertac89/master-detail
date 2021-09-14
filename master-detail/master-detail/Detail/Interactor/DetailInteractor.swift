//
//  DetailInteractor.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 14/09/2021.
//

import Foundation

class DetailInteractor {
    var dataManager: DetailDataManagerProtocol
    var post: Post
    
    init(post: Post, dataManager: DetailDataManagerProtocol) {
        self.post = post
        self.dataManager = dataManager
    }
    
    private func buildPostSectionsWith(comments: [Comment]) -> [PostDetailSections] {
        var postDetailSections = [PostDetailSections]()
        postDetailSections.append(.post(post))
        for comment in comments {
            postDetailSections.append(.comment(comment))
        }
        postDetailSections.append(.addComment)
        return postDetailSections
    }
}

extension DetailInteractor: DetailInteractorProtocol {
    func getCommentsForPost(completion: @escaping (Result<[PostDetailSections], Error>) -> Void) {
        dataManager.getCommentsForPost(id: self.post.id) { (result: Result<[Comment], Error>) in
            switch result {
            case .success(let comments):
                let postDetailSections = self.buildPostSectionsWith(comments: comments)
                completion(.success(postDetailSections))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
