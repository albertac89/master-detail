//
//  PostDetailTableViewCell.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 14/09/2021.
//

import UIKit

class PostDetailTableViewCell: UITableViewCell {
    static let identifier = String(describing: PostDetailTableViewCell.self)
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(post: Post) {
        titleLabel.text = post.title
        titleLabel.font = .boldSystemFont(ofSize: 25)
        bodyLabel.text = post.body
        bodyLabel.font = .systemFont(ofSize: 15)
        separatorView.backgroundColor = .systemPink
    }
}
