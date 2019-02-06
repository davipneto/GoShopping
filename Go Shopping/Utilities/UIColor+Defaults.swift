//
//  DefaulColors.swift
//  Go Shopping
//
//  Created by Davi Pereira Neto on 01/02/19.
//  Copyright © 2019 Davi Pereira Neto. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIColor {
    
    static let listItemExplicit = UIColor.darkText
    static let listItemHidden = UIColor(rgb: 0xC7C7CD)
    
}
