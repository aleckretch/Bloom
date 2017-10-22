//
//  AddCardBillingTableViewCell.swift
//  Bloom
//
//  Created by Alec Kretch on 10/22/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import UIKit

class AddCardBillingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var emailAddressTextFieldWidthConstraint: NSLayoutConstraint! {
        didSet {
            emailAddressTextFieldWidthConstraint.constant = (UIScreen.main.bounds.size.width/2)-16-8
        }
    }
    @IBOutlet weak var phoneNumberTextFieldWidthConstraint: NSLayoutConstraint! {
        didSet {
            phoneNumberTextFieldWidthConstraint.constant = (UIScreen.main.bounds.size.width/2)-16-8
        }
    }
    @IBOutlet weak var line1TextFieldWidthConstraint: NSLayoutConstraint! {
        didSet {
            line1TextFieldWidthConstraint.constant = (UIScreen.main.bounds.size.width/2)-16-8
        }
    }
    @IBOutlet weak var line2TextFieldWidthConstraint: NSLayoutConstraint! {
        didSet {
            line2TextFieldWidthConstraint.constant = (UIScreen.main.bounds.size.width/2)-16-8
        }
    }
    @IBOutlet weak var line3TextFieldWidthConstraint: NSLayoutConstraint! {
        didSet {
            line3TextFieldWidthConstraint.constant = (UIScreen.main.bounds.size.width/2)-16-8
        }
    }
    @IBOutlet weak var cityTextFieldWidthConstraint: NSLayoutConstraint! {
        didSet {
            cityTextFieldWidthConstraint.constant = (UIScreen.main.bounds.size.width/2)-16-8
        }
    }
    @IBOutlet weak var stateTextFieldWidthConstraint: NSLayoutConstraint! {
        didSet {
            stateTextFieldWidthConstraint.constant = (UIScreen.main.bounds.size.width/2)-16-8
        }
    }
    @IBOutlet weak var zipTextFieldWidthConstraint: NSLayoutConstraint! {
        didSet {
            zipTextFieldWidthConstraint.constant = (UIScreen.main.bounds.size.width/2)-16-8
        }
    }
    
    @IBOutlet weak var emailAddressTextField: UITextField! {
        didSet {
            emailAddressTextField.font = UIFont.boldSystemFont(ofSize: 14.0)
            emailAddressTextField.textColor = Constant.Color.lightGray
            emailAddressTextField.borderStyle = .none
            emailAddressTextField.returnKeyType = .next
            emailAddressTextField.autocorrectionType = .no
            emailAddressTextField.keyboardType = .emailAddress
            emailAddressTextField.placeholder = "Email"
            emailAddressTextField.delegate = self
        }
    }
    
    @IBOutlet weak var phoneNumberTextField: UITextField! {
        didSet {
            phoneNumberTextField.font = UIFont.boldSystemFont(ofSize: 14.0)
            phoneNumberTextField.textColor = Constant.Color.lightGray
            phoneNumberTextField.borderStyle = .none
            phoneNumberTextField.returnKeyType = .next
            phoneNumberTextField.autocorrectionType = .no
            phoneNumberTextField.keyboardType = .phonePad
            phoneNumberTextField.placeholder = "Phone"
            phoneNumberTextField.delegate = self
        }
    }
    
    @IBOutlet weak var line1TextField: UITextField! {
        didSet {
            line1TextField.font = UIFont.boldSystemFont(ofSize: 14.0)
            line1TextField.textColor = Constant.Color.lightGray
            line1TextField.borderStyle = .none
            line1TextField.returnKeyType = .next
            line1TextField.autocorrectionType = .no
            line1TextField.autocapitalizationType = .words
            line1TextField.placeholder = "Address"
            line1TextField.delegate = self
        }
    }
    
    @IBOutlet weak var line2TextField: UITextField! {
        didSet {
            line2TextField.font = UIFont.boldSystemFont(ofSize: 14.0)
            line2TextField.textColor = Constant.Color.lightGray
            line2TextField.borderStyle = .none
            line2TextField.returnKeyType = .next
            line2TextField.autocorrectionType = .no
            line2TextField.autocapitalizationType = .words
            line2TextField.placeholder = "Address (cont.)"
            line2TextField.delegate = self
        }
    }
    
    @IBOutlet weak var line3TextField: UITextField! {
        didSet {
            line3TextField.font = UIFont.boldSystemFont(ofSize: 14.0)
            line3TextField.textColor = Constant.Color.lightGray
            line3TextField.borderStyle = .none
            line3TextField.returnKeyType = .next
            line3TextField.autocorrectionType = .no
            line3TextField.keyboardType = .decimalPad
            line3TextField.autocapitalizationType = .words
            line3TextField.placeholder = "Address (cont.)"
            line3TextField.delegate = self
        }
    }
    
    @IBOutlet weak var cityTextField: UITextField! {
        didSet {
            cityTextField.font = UIFont.boldSystemFont(ofSize: 14.0)
            cityTextField.textColor = Constant.Color.lightGray
            cityTextField.borderStyle = .none
            cityTextField.returnKeyType = .next
            cityTextField.autocorrectionType = .no
            cityTextField.autocapitalizationType = .words
            cityTextField.placeholder = "City"
            cityTextField.delegate = self
        }
    }
    
    @IBOutlet weak var stateTextField: UITextField! {
        didSet {
            stateTextField.font = UIFont.boldSystemFont(ofSize: 14.0)
            stateTextField.textColor = Constant.Color.lightGray
            stateTextField.borderStyle = .none
            stateTextField.returnKeyType = .next
            stateTextField.autocorrectionType = .no
            stateTextField.autocapitalizationType = .allCharacters
            stateTextField.placeholder = "State"
            stateTextField.delegate = self
        }
    }
    
    @IBOutlet weak var zipTextField: UITextField! {
        didSet {
            zipTextField.font = UIFont.boldSystemFont(ofSize: 14.0)
            zipTextField.textColor = Constant.Color.lightGray
            zipTextField.borderStyle = .none
            zipTextField.returnKeyType = .next
            zipTextField.autocorrectionType = .no
            zipTextField.keyboardType = .decimalPad
            zipTextField.placeholder = "Zip"
            zipTextField.delegate = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

}

extension AddCardBillingTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailAddressTextField.isFirstResponder {
            phoneNumberTextField.becomeFirstResponder()
        } else if phoneNumberTextField.isFirstResponder {
           line1TextField.becomeFirstResponder()
        } else if line1TextField.isFirstResponder {
            line2TextField.becomeFirstResponder()
        } else if line2TextField.isFirstResponder {
            line3TextField.becomeFirstResponder()
        } else if line3TextField.isFirstResponder {
            cityTextField.becomeFirstResponder()
        } else if cityTextField.isFirstResponder {
            stateTextField.becomeFirstResponder()
        } else if stateTextField.isFirstResponder {
            zipTextField.becomeFirstResponder()
        } else if zipTextField.isFirstResponder {
            zipTextField.resignFirstResponder()
        }
        return false
    }
    
}
