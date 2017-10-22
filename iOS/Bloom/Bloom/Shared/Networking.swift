//
//  Networking.swift
//  Bloom
//
//  Created by Alec Kretch on 10/21/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class Networking {
    
    fileprivate var request: Request? = nil
    var isRequesting = false
    
    func cancel() {
        request?.cancel()
    }
    
    func request(urlString: String, method: Alamofire.HTTPMethod = .get, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default, responseQueue: DispatchQueue? = nil, qualityOfService: DispatchQoS.QoSClass = .unspecified, numberOfTimes: Int? = 1, completion: @escaping (_ data: Any?)->()) {
        request?.cancel()
        isRequesting = true
        /*var requestParams:[String:Any]? = nil
        if let parametersTemp = parameters as? [String: String] {
            var parametersFiltered = parametersTemp
            let keysToRemove = parametersTemp.keys.filter { parametersTemp[$0]! == "" }
            for key in keysToRemove {
                parametersFiltered.removeValue(forKey: key)
            }
            requestParams = parametersFiltered
        }*/
        var queue: DispatchQueue? = responseQueue
        if queue == nil {
            switch qualityOfService {
            case .unspecified:
                queue = DispatchQueue.main
            case .userInteractive:
                queue = DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:
                queue = DispatchQueue.global(qos: .userInitiated)
            case .utility:
                queue = DispatchQueue.global(qos: .utility)
            case .`default`:
                queue = DispatchQueue.global(qos: .`default`)
            case .background:
                queue = DispatchQueue.global(qos: .background)
            }
        }
        request = Alamofire.request(urlString, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON(queue: queue) { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let data = JSON(value).object
                    completion(data)
                } else {
                    completion(nil)
                }
            case .failure(_):
                completion(nil)
            }
            self.isRequesting = false
        }
    }
    
    deinit {
        
    }
    
}
