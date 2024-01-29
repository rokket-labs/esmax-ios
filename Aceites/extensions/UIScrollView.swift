//
//  UIScrollView.swift
//  Aceites
//
//  Created by Eddwin Paz on 10/27/18.
//  Copyright © 2018 Esmax. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    func showEmptyListMessage(_ message:String) {
        
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor(red: 0.224, green: 0.698, blue: 0.667, alpha: 1.0)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 18).bold()
        messageLabel.sizeToFit()
        
        
        if let `self` = self as? UITableView {
            if message.count != 0 {
                print("message character count: ",message.count)
                self.backgroundView = messageLabel
                self.separatorStyle = .none
            }
        } else if let `self` = self as? UICollectionView {
            self.backgroundView = messageLabel
        }
    }
}
