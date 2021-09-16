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
    var endEditing: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(callbackSendPost: ((String?) -> Void)?, endEditing: (() -> Void)?) {
        self.callbackSendPost = callbackSendPost
        self.endEditing = endEditing
        textView.tintColor = .systemPink
        textView.layer.borderColor = UIColor.systemPink.cgColor
        textView.layer.borderWidth = 2.0
        postMessageButton.setTitle("Add comment", for: .normal)
        postMessageButton.setImage(UIImage(systemName: "text.bubble.fill"), for: .normal)
        postMessageButton.tintColor = .white
        postMessageButton.backgroundColor = .systemPink
        setupTextView()
    }
    
    func setupTextView() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        textView.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        guard let action = endEditing else { return }
        action()
    }
    
    @IBAction func addCommentButtonClicked(_ sender: Any) {
        guard let action = self.callbackSendPost else { return }
        action(textView.text)
        textView.text = ""
    }
}
