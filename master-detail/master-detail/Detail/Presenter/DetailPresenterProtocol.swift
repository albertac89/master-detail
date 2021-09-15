//
//  DetailPresenterProtocol.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 14/09/2021.
//

import Foundation

protocol DetailPresenterProtocol {
    func getCommentsDetails()
    func addComment(postId: Int, id: Int, body: String)
}
