//
//  DetailBuilder.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation
import UIKit

class DetailBuilder {
    static func build(post: Post) -> UIViewController {
        let apiClient = APIClient()
        let dataManager = DetailDataManager(apiClient: apiClient)
        let interactor = DetailInteractor(post: post, dataManager: dataManager)
        let presenter = DetailPresenter(interactor: interactor)
        let view = DetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
