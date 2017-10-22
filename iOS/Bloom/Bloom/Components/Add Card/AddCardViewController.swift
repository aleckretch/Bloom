//
//  AddCardViewController.swift
//  Bloom
//
//  Created by Alec Kretch on 10/21/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import UIKit

protocol AddCardViewControllerDelegate {
    
    func addCardViewControllerAddedCardSuccessfully(_ addCardViewController:AddCardViewController)
    
}

final class AddCardViewController: UIViewController {
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    var delegate:AddCardViewControllerDelegate? = nil
    var saveCell:AddCardSaveTableViewCell?
    var cardCell:AddCardDetailsTableViewCell?
    var billingCell:AddCardBillingTableViewCell?
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBOutlet weak var tableView:UITableView! {
        didSet {
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @objc func onTapButtonDismiss() {
        for subview in (cardCell?.contentView.subviews)! {
            if let textField = subview as? UITextField {
                textField.resignFirstResponder()
            }
        }
        for subview in (billingCell?.contentView.subviews)! {
            if let textField = subview as? UITextField {
                textField.resignFirstResponder()
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onTapButtonSaveCard() {
        if let cell = saveCell {
            cell.saveButtonTapped()
            if let cardExpirationString = cardCell?.expirationDateTextField.text, cardExpirationString.characters.count > 0, let firstName = cardCell?.firstNameTextField.text, firstName.characters.count > 0, let lastName = cardCell?.lastNameTextField.text, lastName.characters.count > 0, let phoneNumber = billingCell?.phoneNumberTextField.text, phoneNumber.characters.count > 0, let emailAddress = billingCell?.emailAddressTextField.text, emailAddress.characters.count > 0, let addressLine1 = billingCell?.line1TextField.text, addressLine1.characters.count > 0, let addressCity = billingCell?.cityTextField.text, addressCity.characters.count > 0, let addressState = billingCell?.stateTextField.text, addressState.characters.count > 0, let addressZip = billingCell?.zipTextField.text, addressZip.characters.count > 0, let cardNumber = cardCell?.numberTextField.text, cardNumber.characters.count > 0 {
                let cardExpirationMonthStart = cardExpirationString.index(cardExpirationString.startIndex, offsetBy: 0)
                let cardExpirationMonthEnd = cardExpirationString.index(cardExpirationString.startIndex, offsetBy: 2)
                let cardExpirationYearStart = cardExpirationString.index(cardExpirationString.startIndex, offsetBy: 3)
                let cardExpirationYearEnd = cardExpirationString.index(cardExpirationString.endIndex, offsetBy: 0)
                let cardExpiration = String(format:"%@/20%@", String(cardExpirationString[cardExpirationMonthStart..<cardExpirationMonthEnd]), String(cardExpirationString[cardExpirationYearStart..<cardExpirationYearEnd]))
                let addressLine2:String? = billingCell?.line2TextField.text
                let addressLine3:String? = billingCell?.line3TextField.text
                AddCardManager.shared.createCustomerInBackground(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, emailAddress: emailAddress, addressLine1: addressLine1, addressLine2: addressLine2, addressLine3: addressLine3, addressCity: addressCity, addressState: addressState, addressZip: addressZip) { (success, customerId) in
                    if success, let userId = customerId {
                        AddCardManager.shared.createPaymentAccountInBackground(customerId: userId, cardNumber: cardNumber, cardExpiration: cardExpiration, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, addressLine1: addressLine1, addressLine2: addressLine2, addressLine3: addressLine3, addressCity: addressCity, addressState: addressState, addressZip: addressZip, completion: { (success) in
                            if success {
                                //save to user defaults
                                UserDefaults.standard.set(customerId, forKey: "customerId")
                                UserDefaults.standard.set(firstName, forKey: "firstName")
                                UserDefaults.standard.set(lastName, forKey: "lastName")
                                UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
                                UserDefaults.standard.set(emailAddress, forKey: "emailAddress")
                                UserDefaults.standard.set(addressLine1, forKey: "addressLine1")
                                UserDefaults.standard.set(addressLine2, forKey: "addressLine2")
                                UserDefaults.standard.set(addressLine3, forKey: "addressLine3")
                                UserDefaults.standard.set(addressCity, forKey: "addressCity")
                                UserDefaults.standard.set(addressState, forKey: "addressState")
                                UserDefaults.standard.set(addressZip, forKey: "addressZip")
                                UserDefaults.standard.set(cardNumber, forKey: "cardNumber")
                                UserDefaults.standard.set(customerId, forKey: "cardExpiration")
                                self.onTapButtonDismiss()
                            } else {
                                let alertController = UIAlertController(title: "An Error Occurred", message: "Make sure you are connected to the Internet and all of your information is correct.", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                                self.present(alertController, animated: true, completion: nil)
                                self.saveCell?.showSave()
                            }
                        })
                    } else {
                        let alertController = UIAlertController(title: "An Error Occurred", message: "Make sure you are connected to the Internet and all of your information is correct.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                        self.saveCell?.showSave()
                    }
                }
            } else {
                let alertController = UIAlertController(title: "An Error Occurred", message: "Make sure you complete all required items to add your credit card.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                present(alertController, animated: true, completion: nil)
                self.saveCell?.showSave()
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableViewBottomConstraint.constant = keyboardSize.height
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        tableViewBottomConstraint.constant = 0
        view.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension AddCardViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardHeaderTVCID", for: indexPath) as! AddCardHeaderTableViewCell
            cell.titleLabel.text = "Set Credit Card"
            cell.titleLabel.textColor = Constant.Color.purple
            cell.dismissButton.addTarget(self, action: #selector(onTapButtonDismiss), for: .touchUpInside)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardTextTVCID", for: indexPath) as! AddCardTextTableViewCell
            cell.descriptionLabel.text = "Set or change your credit card below for automatic and seamless payments at your favorite local spots!"
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardDetailsTVCID", for: indexPath) as! AddCardDetailsTableViewCell
            if let cardNumber = UserDefaults.standard.string(forKey: "cardNumber"), let cardExpiration = UserDefaults.standard.string(forKey: "cardExpiration"), let firstName = UserDefaults.standard.string(forKey: "firstName"), let lastName = UserDefaults.standard.string(forKey: "lastName") {
                cell.setCardNumber(number: cardNumber)
                cell.expirationDateTextField.text = cardExpiration
                cell.firstNameTextField.text = firstName
                cell.lastNameTextField.text = lastName
            } else {
                cell.setCardNumber(number: nil)
            }
            cardCell = cell
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardSmallHeaderTVCID", for: indexPath) as! AddCardSmallHeaderTableViewCell
            cell.titleLabel.text = "Billing Address"
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardBillingTVCID", for: indexPath) as! AddCardBillingTableViewCell
            if let emailAddress = UserDefaults.standard.string(forKey: "emailAddress"), let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber"), let addressLine1 = UserDefaults.standard.string(forKey: "addressLine1"), let addressCity = UserDefaults.standard.string(forKey: "addressCity"), let addressState = UserDefaults.standard.string(forKey: "addressState"), let addressZip = UserDefaults.standard.string(forKey: "addressZip") {
                cell.emailAddressTextField.text = emailAddress
                cell.phoneNumberTextField.text = phoneNumber
                cell.line1TextField.text = addressLine1
                cell.cityTextField.text = addressCity
                cell.stateTextField.text = addressState
                cell.zipTextField.text = addressZip
                if let addressLine2 = UserDefaults.standard.string(forKey: "addressLine2") {
                    cell.line2TextField.text = addressLine2
                }
                if let addressLine3 = UserDefaults.standard.string(forKey: "addressLine3") {
                    cell.line3TextField.text = addressLine3
                }
            }
            billingCell = cell
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardSaveTVCID", for: indexPath) as! AddCardSaveTableViewCell
            cell.saveButton.addTarget(self, action: #selector(onTapButtonSaveCard), for: .touchUpInside)
            saveCell = cell
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
