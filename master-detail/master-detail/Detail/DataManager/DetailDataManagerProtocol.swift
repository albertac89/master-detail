//
//  DetailDataManagerProtocol.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 14/09/2021.
//

import Foundation

protocol DetailDataManagerProtocol {
    func getCommentsForPost(id: Int, completion: @escaping (Result<[Comment], Error>) -> Void)
}
