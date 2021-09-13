//
//  DetailViewController.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post"
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
    }
}
