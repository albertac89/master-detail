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
        configureNavBar()
        configureKeyboard()
        setupTableView()
        presenter.getCommentsDetails()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureNavBar() {
        navigationItem.title = "Post"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
    }
    
    private func configureKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: PostDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PostDetailTableViewCell.identifier)
        tableView.register(UINib(nibName: CommentTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CommentTableViewCell.identifier)
        tableView.register(UINib(nibName: MessageTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MessageTableViewCell.identifier)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    private func addComment(text: String?) {
        guard let comment = text, !comment.isEmpty else {
            return }
        presenter.addComment(body: comment)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func setupData(sections: [PostDetailSections], scrollBottom: Bool = false) {
        DispatchQueue.main.async {
            self.data = sections
            if scrollBottom { self.tableView.scrollToBottom() }
        }
    }
    
    func showMessage(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
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
            let cell: MessageTableViewCell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.identifier, for: indexPath) as! MessageTableViewCell
            cell.configure { text in
                self.addComment(text: text)
            } endEditing: {
                self.view.endEditing(true)
            }
            return cell
        }
    }
}
