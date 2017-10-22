//
//  AddCardHeaderTableViewCell.swift
//  Bloom
//
//  Created by Alec Kretch on 10/22/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import UIKit

class AddCardHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
            titleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var dismissButton: UIButton! {
        didSet {
            dismissButton.isExclusiveTouch = true
            dismissButton.tintColor = Constant.Color.lightGray
            dismissButton.setImage(UIImage(named:"iconDismiss"), for: .normal)
            dismissButton.contentMode = .center
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.size.width * 2)
        // Initialization code
    }
    
}
