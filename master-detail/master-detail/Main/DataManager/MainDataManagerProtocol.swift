//
//  MainDataManagerProtocol.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation

protocol MainDataManagerProtocol {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}
