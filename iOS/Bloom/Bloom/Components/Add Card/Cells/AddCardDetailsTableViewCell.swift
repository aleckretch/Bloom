//
//  AddCardDetailsTableViewCell.swift
//  Bloom
//
//  Created by Alec Kretch on 10/22/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import UIKit

class AddCardDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstNameTextViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lastNameTextViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var expirationDateTextViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cardImageView: UIImageView! {
        didSet {
            cardImageView.clipsToBounds = true
            cardImageView.layer.cornerRadius = 16.0
        }
    }
    
    @IBOutlet weak var numberTextField: UITextField! {
        didSet {
            numberTextField.font = UIFont.boldSystemFont(ofSize: 26.0)
            numberTextField.textColor = Constant.Color.purple
            numberTextField.borderStyle = .none
            numberTextField.returnKeyType = .next
            numberTextField.autocorrectionType = .no
            numberTextField.keyboardType = .decimalPad
            numberTextField.delegate = self
            defaultTextFieldTintColor = numberTextField.tintColor
        }
    }
    
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.font = UIFont.systemFont(ofSize: 18.0)
            firstNameTextField.textColor = Constant.Color.green
            firstNameTextField.borderStyle = .none
            firstNameTextField.returnKeyType = .next
            firstNameTextField.autocorrectionType = .no
            firstNameTextField.autocapitalizationType = .words
            firstNameTextField.delegate = self
            firstNameTextField.placeholder = "First"
        }
    }
    
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            lastNameTextField.font = UIFont.systemFont(ofSize: 18.0)
            lastNameTextField.textColor = Constant.Color.green
            lastNameTextField.borderStyle = .none
            lastNameTextField.returnKeyType = .next
            lastNameTextField.autocorrectionType = .no
            lastNameTextField.autocapitalizationType = .words
            lastNameTextField.delegate = self
            lastNameTextField.placeholder = "Last"
        }
    }
    
    @IBOutlet weak var expirationDateTextField: UITextField! {
        didSet {
            expirationDateTextField.font = UIFont.systemFont(ofSize: 18.0)
            expirationDateTextField.textColor = Constant.Color.green
            expirationDateTextField.borderStyle = .none
            expirationDateTextField.returnKeyType = .next
            expirationDateTextField.autocorrectionType = .no
            expirationDateTextField.autocapitalizationType = .none
            expirationDateTextField.keyboardType = .decimalPad
            expirationDateTextField.textAlignment = .right
            expirationDateTextField.delegate = self
            expirationDateTextField.placeholder = "MM/YY"
        }
    }
    
    var defaultTextFieldTintColor:UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.size.width * 2)
        cardImageViewWidthConstraint.constant = UIScreen.main.bounds.size.width
        cardImageViewHeightConstraint.constant = 0.60*cardImageViewWidthConstraint.constant
        firstNameTextViewWidthConstraint.constant = (firstNameTextField.placeholder?.width(with: firstNameTextField.font!))!
        lastNameTextViewWidthConstraint.constant = (lastNameTextField.placeholder?.width(with: lastNameTextField.font!))!
        expirationDateTextViewWidthConstraint.constant = (expirationDateTextField.placeholder?.width(with: expirationDateTextField.font!))!
        layoutIfNeeded()
    }
    
    func setCardTextForNumber(number: String?) {
        if number != nil {
            let decimalRange = number!.rangeOfCharacter(from: .decimalDigits)
            if decimalRange == nil { //no numbers exist in string
                numberTextField.tintColor = UIColor.clear
                numberTextField.text = number!
                numberTextField.textColor = Constant.Color.purpleAlpha
            } else if number!.contains("X") {
                numberTextField.tintColor = UIColor.clear
                numberTextField.text = number!
                numberTextField.textColor = Constant.Color.purple
            } else if !number!.contains("-") {
                numberTextField.tintColor = UIColor.clear
                numberTextField.text = number!
                numberTextField.textColor = Constant.Color.purple
            } else {
                numberTextField.tintColor = UIColor.clear
                let attributedNumber = NSMutableAttributedString(string: number!)
                var firstDash:Int = 0
                for character in number!.characters {
                    if character == "-" {
                        break
                    }
                    firstDash += 1
                }
                attributedNumber.addAttribute(NSAttributedStringKey.foregroundColor, value: Constant.Color.purple, range: NSMakeRange(0, firstDash))
                attributedNumber.addAttribute(NSAttributedStringKey.foregroundColor, value: Constant.Color.purpleAlpha, range: NSMakeRange(firstDash, number!.characters.count-(firstDash+1)))
                numberTextField.attributedText = attributedNumber
            }
        } else {
            numberTextField.text = "---- ---- ---- ----"
            numberTextField.textColor = Constant.Color.purpleAlpha
            numberTextField.tintColor = defaultTextFieldTintColor
            numberTextField.selectedTextRange = numberTextField.textRange(from: numberTextField.beginningOfDocument, to: numberTextField.beginningOfDocument)
        }
    }
    
    func setCardNumber(number: String?) {
        setCardTextForNumber(number: number)
    }
    
}

extension AddCardDetailsTableViewCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == numberTextField {
            if string == "" {
                setCardTextForNumber(number: nil)
            } else {
                if let text = textField.text {
                    var firstDash:Int = 0
                    for character in text.characters {
                        if character == "-" {
                            break
                        }
                        firstDash += 1
                    }
                    if firstDash >= 19 { //there are no dashes and string is full
                        return false
                    } else {
                        let nsText = textField.text! as NSString
                        if range.location < firstDash {
                            setCardTextForNumber(number: String(format:"%@--- ---- ---- ----", String(string[string.index(string.startIndex, offsetBy: 0)])))
                        } else {
                            setCardTextForNumber(number: nsText.replacingCharacters(in: NSMakeRange(firstDash, 1), with: string))
                        }
                    }
                }
            }
            return false
        } else {
            let nsText = textField.text! as NSString
            if textField == firstNameTextField {
                textField.text = nsText.replacingCharacters(in: range, with: string)
                if let text = textField.text, text.characters.count > 0 {
                    firstNameTextViewWidthConstraint.constant = (textField.text?.width(with: firstNameTextField.font!))!
                } else {
                    firstNameTextViewWidthConstraint.constant = textField.placeholder!.width(with: textField.font!)
                }
            } else if textField == lastNameTextField {
                textField.text = nsText.replacingCharacters(in: range, with: string)
                if let text = textField.text, text.characters.count > 0 {
                    lastNameTextViewWidthConstraint.constant = (textField.text?.width(with: textField.font!))!
                } else {
                    lastNameTextViewWidthConstraint.constant = textField.placeholder!.width(with: textField.font!)
                }
            } else if textField == expirationDateTextField {
                if nsText.length+string.characters.count <= 5 {
                    textField.text = nsText.replacingCharacters(in: range, with: string)
                    if textField.text!.characters.count == 2, string.characters.count > 0  {
                        textField.text = String(format:"%@/", textField.text!)
                    } else if string.characters.count == 0 {
                        textField.text = ""
                    }
                    if textField.text!.contains("/") {
                        let splits = textField.text?.split(separator: "/")
                        let firstHalf = splits![0]
                        if firstHalf.characters.count > 2 {
                            textField.text = ""
                        }
                    }
                    if let text = textField.text, text.characters.count > 0 {
                        expirationDateTextViewWidthConstraint.constant = (textField.text?.width(with: expirationDateTextField.font!))!
                    } else {
                        expirationDateTextViewWidthConstraint.constant = textField.placeholder!.width(with: textField.font!)
                    }
                }
            }
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        numberTextField.selectedTextRange = numberTextField.textRange(from: numberTextField.beginningOfDocument, to: numberTextField.beginningOfDocument)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if numberTextField.isFirstResponder {
            firstNameTextField.becomeFirstResponder()
        } else if firstNameTextField.isFirstResponder {
            lastNameTextField.becomeFirstResponder()
        } else if lastNameTextField.isFirstResponder {
            expirationDateTextField.becomeFirstResponder()
        } else if expirationDateTextField.isFirstResponder {
            expirationDateTextField.resignFirstResponder()
        }
        return false
    }
    
}
