//
//  MainPresenter.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation

class MainPresenter {
    weak var view: MainViewControllerProtocol?
    var interactor: MainInteractorProtocol
    var router: MainRouterProtocol
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MainPresenter: MainPresenterProtocol {
    
}
