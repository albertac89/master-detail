//
//  UITableView+extension.swift
//  master-detail
//
//  Created by Aige Cortasa, Albert on 15/09/2021.
//
import UIKit

extension UITableView {
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func hasRowAtIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
