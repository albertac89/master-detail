//
//  DetailPresenter.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 14/09/2021.
//

import Foundation

class DetailPresenter {
    weak var view: DetailViewControllerProtocol?
    var interactor: DetailInteractorProtocol
    
    init(interactor: DetailInteractorProtocol) {
        self.interactor = interactor
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func getCommentsDetails() {
        view?.startActivityIndicator()
        interactor.getCommentsForPost() { [weak self] (result: Result<[PostDetailSections], Error>) in
            self?.view?.stopActivityIndicator()
            switch result {
            case .success(let postDetailSections):
                self?.view?.setupData(sections: postDetailSections, scrollBottom: false)
            case .failure(let error):
                self?.view?.showMessage(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func addComment(body: String) {
        view?.startActivityIndicator()
        interactor.addCommentForPost(body: body) { [weak self] (result: Result<[PostDetailSections], Error>) in
            self?.view?.stopActivityIndicator()
            switch result {
            case .success(let postDetailSections):
                self?.view?.setupData(sections: postDetailSections, scrollBottom: true)
            case .failure(let error):
                self?.view?.showMessage(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
