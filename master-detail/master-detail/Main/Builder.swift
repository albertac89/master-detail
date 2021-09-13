//
//  Builder.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation
import UIKit

class MainBuilder {
    static func build() -> UIViewController {
        let dataManager = MainDataManager()
        let interactor = MainInteractor(dataManager: dataManager)
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interactor, router: router)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        router.view = view
        return view
    }
}
