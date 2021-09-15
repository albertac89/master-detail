//
//  DetailInteractorProtocol.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 14/09/2021.
//

import Foundation

protocol DetailInteractorProtocol {
    func getCommentsForPost(completion: @escaping (Result<[PostDetailSections], Error>) -> Void)
    func addCommentForPost(comment: Comment, completion: @escaping (Result<Comment, Error>) -> Void)
}
