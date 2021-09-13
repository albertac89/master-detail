//
//  PostTableViewCell.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 13/09/2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    static let identifier = "PostTableViewCell"
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postSummaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(post: Post) {
        postTitleLabel.text = post.title
        postTitleLabel.font = .boldSystemFont(ofSize: 24)
        postSummaryLabel.text = String(post.body.prefix(80)) + "..."
        postSummaryLabel.font = .systemFont(ofSize: 15)
        postView.layer.borderWidth = 2
        postView.layer.borderColor = UIColor.systemPink.cgColor
        postView.layer.cornerRadius = 10
    }
}
