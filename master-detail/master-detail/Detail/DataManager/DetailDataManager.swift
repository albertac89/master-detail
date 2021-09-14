//
//  DetailDataManager.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 14/09/2021.
//

import Foundation

class DetailDataManager {
    var apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
}

extension DetailDataManager: DetailDataManagerProtocol {
    func getCommentsForPost(id: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        apiClient.fetch(with: .get, path: "/comments", params: ["postId" : id]) { (result: Result<[Comment], Error>) in
            completion(result)
        }
    }
}
