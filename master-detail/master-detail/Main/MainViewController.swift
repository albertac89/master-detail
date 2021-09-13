//
//  MainViewController.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "JSONPlaceholder"
        
        let apiClient = APIClient()
        
        apiClient.fetch(with: .get, path: "/posts", body: nil) { (result: Result<[Posts], Error>) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
