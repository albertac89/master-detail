//
//  MainInteractor.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation

class MainInteractor {
    var dataManager: MainDataManagerProtocol
    
    init(dataManager: MainDataManagerProtocol) {
        self.dataManager = dataManager
    }
}

extension MainInteractor: MainInteractorProtocol {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        dataManager.getPosts { (result: Result<[Post], Error>) in
            completion(result)
        }
    }
}
