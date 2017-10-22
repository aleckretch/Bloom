//
//  AddCardSmallHeaderTableViewCell.swift
//  Bloom
//
//  Created by Alec Kretch on 10/22/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import UIKit

class AddCardSmallHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
            titleLabel.textColor = UIColor.darkGray
            titleLabel.numberOfLines = 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.size.width * 2)
        // Initialization code
    }
    
}
