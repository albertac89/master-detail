//
//  CommentTableViewCell.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 14/09/2021.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    static let identifier = String(describing: CommentTableViewCell.self)
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(comment: Comment) {
        contentLabel.text = comment.body
        contentLabel.font = .systemFont(ofSize: 15)
        authorLabel.text = comment.email
        authorLabel.textColor = .gray
        authorLabel.font = .systemFont(ofSize: 10)
        separatorView.backgroundColor = .systemPink
    }
}
