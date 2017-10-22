//
//  AddCardTextTableViewCell.swift
//  Bloom
//
//  Created by Alec Kretch on 10/22/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import UIKit

class AddCardTextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = UIFont.systemFont(ofSize: 14.0)
            descriptionLabel.textColor = Constant.Color.lightGray
            descriptionLabel.numberOfLines = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.size.width * 2)
        // Initialization code
    }
    
}
