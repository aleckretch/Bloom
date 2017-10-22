//
//  AddCardSaveTableViewCell.swift
//  Bloom
//
//  Created by Alec Kretch on 10/22/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import UIKit

class AddCardSaveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.isExclusiveTouch = true
            saveButton.tintColor = Constant.Color.green
            saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
            saveButton.setTitle("Save", for: .normal)
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.tintColor = Constant.Color.green
            activityIndicator.isHidden = true
        }
    }
    
    func saveButtonTapped() {
        saveButton.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func showSave() {
        saveButton.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.size.width * 2)
        // Initialization code
    }
    
}
