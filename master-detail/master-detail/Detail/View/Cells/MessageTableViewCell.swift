//
//  MessageTableViewCell.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 15/09/2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    static let identifier = String(describing: MessageTableViewCell.self)
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postMessageButton: UIButton!
    var callbackSendPost: ((String?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(callbackSendPost: ((String?) -> Void)?) {
        self.callbackSendPost = callbackSendPost
        textView.tintColor = .systemPink
        textView.layer.borderColor = UIColor.systemPink.cgColor
        textView.layer.borderWidth = 2.0
        postMessageButton.setTitle("Add comment", for: .normal)
        postMessageButton.setImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        postMessageButton.tintColor = .white
        postMessageButton.backgroundColor = .systemPink
    }
    
    @IBAction func addCommentButtonClicked(_ sender: Any) {
        guard let action = self.callbackSendPost else { return }
        action(textView.text)
        textView.text = ""
    }
}
