//
//  MainRouter.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import Foundation
import UIKit

class MainRouter {
    weak var view: UIViewController?
}

extension MainRouter: MainRouterProtocol {
    func openDetail(post: Post) {
        guard let vc = view else {
            assertionFailure("we need the view for show")
            return
        }
        let detailVc = DetailBuilder.build(post: post)
        vc.navigationController?.pushViewController(detailVc, animated: true)
    }
}
