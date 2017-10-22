//
//  Extension.swift
//  Bloom
//
//  Created by Alec Kretch on 10/22/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func width(with font: UIFont) -> CGFloat {
        return (self as NSString).size(withAttributes: [NSAttributedStringKey.font: font]).width + 2.0
    }
    
}
