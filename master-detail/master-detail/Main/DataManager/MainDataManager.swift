//
//  MainDataManager.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation

class MainDataManager {
    var apiClient = APIClient()
}

extension MainDataManager: MainDataManagerProtocol {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        apiClient.fetch(with: .get, path: "/posts", body: nil) { (result: Result<[Post], Error>) in
            completion(result)
        }
    }
}
