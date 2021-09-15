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
    var networkMonitor: NetworkMonitor
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol, networkMonitor: NetworkMonitor) {
        self.interactor = interactor
        self.router = router
        self.networkMonitor = networkMonitor
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
                self?.view?.showMessage(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func openDetail(post: Post) {
        if networkMonitor.isNetworkAvailable ?? false {
            router.openDetail(post: post)
        } else {
            self.view?.showMessage(title: "Error", message: "No internet connection")
        }
    }
}
