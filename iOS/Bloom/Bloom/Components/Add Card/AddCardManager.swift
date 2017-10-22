//
//  AddCardManager.swift
//  Bloom
//
//  Created by Alec Kretch on 10/21/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class AddCardManager {
    
    static let shared = AddCardManager()
    let networking = Networking()
    
    var worldPayHeaders:HTTPHeaders {
        get {
            let snid = Constant.ThirdPartyKey.WorldPay.secureNetId
            let skey = Constant.ThirdPartyKey.WorldPay.secureKey
            let secureBase = String(format:"%@:%@", snid, skey)
            let utf8SecureBase = secureBase.data(using: .utf8)
            let b64SecureBase = utf8SecureBase!.base64EncodedString()
            let authId = String(format:"Basic %@", b64SecureBase)
            let headers = ["Authorization":authId, "Content-Type":"application/json", "Accept":"application/json"]
            return headers
        }
    }
    
    func createCustomerInBackground(firstName: String, lastName: String, phoneNumber: String, emailAddress: String, addressLine1: String, addressLine2: String? = nil, addressLine3: String? = nil, addressCity: String, addressState: String, addressZip: String, completion: ((_ success: Bool, _ customerId: String?)->())?) {
        var addressParameter:[String:Any] = ["line1":addressLine1, "city":addressCity, "state":addressState, "zip":addressZip]
        if let line2 = addressLine2 {
            addressParameter["line2"] = line2
            if let line3 = addressLine3 {
                addressParameter["line3"] = line3
            }
        }
        let developerApplicationParameter = ["developerId":Constant.ThirdPartyKey.WorldPay.developerId, "version": Constant.ThirdPartyKey.WorldPay.version] as [String : Any]
        let parameters = ["firstName":firstName, "lastName":lastName, "phoneNumber":phoneNumber, "emailAddress":emailAddress, "sendEmailReceipts":true, "customerDuplicateCheckIndicator":1, "address":addressParameter, "developerApplication":developerApplicationParameter] as [String : Any]
        let worldPayCreateCustomerApiUrlBase = "https://gwapi.demo.securenet.com/api/Customers"
        DispatchQueue.global(qos: .background).async {
            self.networking.request(urlString: worldPayCreateCustomerApiUrlBase, method: .post, parameters: parameters, headers: self.worldPayHeaders, encoding: Alamofire.JSONEncoding.default, qualityOfService: .userInitiated) { (data) in
                DispatchQueue.main.async {
                    if data != nil {
                        let json = JSON(data!)
                        let customerId = json["customerId"].stringValue
                        if customerId.characters.count > 0 {
                            completion?(true, customerId)
                        } else {
                            completion?(false, nil)
                        }
                    } else {
                        completion?(false, nil)
                    }
                }
            }
        }
    }
    
    func createPaymentAccountInBackground(customerId: String, cardNumber: String, cardExpiration: String, firstName: String, lastName: String, phoneNumber: String, addressLine1: String, addressLine2: String? = nil, addressLine3: String? = nil, addressCity: String, addressState: String, addressZip: String, completion: ((_ success: Bool)->())?) {
        var addressParameter:[String:Any] = ["line1":addressLine1, "city":addressCity, "state":addressState, "zip":addressZip]
        if let line2 = addressLine2 {
            addressParameter["line2"] = line2
            if let line3 = addressLine3 {
                addressParameter["line3"] = line3
            }
        }
        let cardParameters:[String:Any] = ["number":cardNumber, "expirationDate":cardExpiration, "firstName":firstName, "lastName":lastName, "address":addressParameter]
        let developerApplicationParameter = ["developerId":Constant.ThirdPartyKey.WorldPay.developerId, "version": Constant.ThirdPartyKey.WorldPay.version] as [String : Any]
        let parameters = ["customerId":customerId, "phoneNumber":phoneNumber, "accountDuplicateCheckIndicator":0, "primary":true, "card":cardParameters, "developerApplication":developerApplicationParameter] as [String : Any]
        let worldPayCreatePaymentAccountApiUrlBase = String(format:"https://gwapi.demo.securenet.com/api/Customers/%@/PaymentMethod", customerId)
        DispatchQueue.global(qos: .background).async {
            self.networking.request(urlString: worldPayCreatePaymentAccountApiUrlBase, method: .post, parameters: parameters, headers: self.worldPayHeaders, encoding: Alamofire.JSONEncoding.default, qualityOfService: .userInitiated) { (data) in
                DispatchQueue.main.async {
                    if data != nil {
                        let json = JSON(data!)
                        let responseCode = json["responseCode"].intValue
                        if responseCode == 1 {
                            completion?(true)
                        } else {
                            completion?(false)
                        }
                    } else {
                        completion?(false)
                    }
                }
            }
        }
    }
    
}
