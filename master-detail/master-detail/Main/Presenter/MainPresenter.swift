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
    func getPosts() {
        view?.startActivityIndicator()
        interactor.getPosts { [weak self] result in
            self?.view?.stopActivityIndicator()
            switch result {
            case .success(let data):
                self?.view?.setupData(posts: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func openDetail(post: Post) {
        router.openDetail(post: post)
    }
}
