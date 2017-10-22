//
//  Constant.swift
//  Bloom
//
//  Created by Alec Kretch on 10/21/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    struct Color {
        static let purple = UIColor(red: 162.0/255.0, green: 142.0/255.0, blue: 195.0/255.0, alpha: 1)
        static let purpleAlpha = UIColor(red: 162.0/255.0, green: 142.0/255.0, blue: 195.0/255.0, alpha: 0.1)
        static let turqoise = UIColor(red: 31.0/255.0, green: 86.0/255.0, blue: 104.0/255.0, alpha: 1)
        static let green = UIColor(red: 69.0/255.0, green: 140.0/255.0, blue: 73.0/255.0, alpha: 1)
        static let lightGray = UIColor(red: 136.0/255.0, green: 136.0/255.0, blue: 136.0/255.0, alpha: 1)
    }
    
    struct ThirdPartyKey {
        
        struct WorldPay {
            static let developerId = 12345678
            static let version = "1.0"
            static let secureNetId = "8011038"
            static let secureKey = "DvAdFBTiBODp"
        }
        
    }

}
