//
//  DetailViewController.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import UIKit

class DetailViewController: UIViewController {
    var presenter: DetailPresenterProtocol
    @IBOutlet weak var tableView: UITableView!
    private var data: [PostDetailSections] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Post"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
        
        setupTableView()
        presenter.getCommentsDetails()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: PostDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PostDetailTableViewCell.identifier)
        tableView.register(UINib(nibName: CommentTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CommentTableViewCell.identifier)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func setupData(sections: [PostDetailSections]) {
        DispatchQueue.main.async {
            self.data = sections
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let section =  data[indexPath.row]
        switch section {
        case .post(let post):
            let cell: PostDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: PostDetailTableViewCell.identifier, for: indexPath) as! PostDetailTableViewCell
            cell.configure(post: post)
            return cell
        case .comment(let comment):
            let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
            cell.configure(comment: comment)
            return cell
        case .addComment:
            return UITableViewCell()
        }
    }
}
