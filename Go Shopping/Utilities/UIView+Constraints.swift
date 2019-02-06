//
//  UIView+Constraints.swift
//  Go Shopping
//
//  Created by Davi Pereira Neto on 30/01/19.
//  Copyright © 2019 Davi Pereira Neto. All rights reserved.
//

import UIKit

extension UIView {
    
    func prepareForConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func pinEdgesToSuperview(offset: CGFloat = 0.0) {
        guard let superview = self.superview else {
            return
        }
        self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset).isActive = true
        self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -offset).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -offset).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset).isActive = true
    }
    
    func pinLeftToSuperview(offset: CGFloat = 0.0) {
        guard let superview = self.superview else {
            return
        }
        self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: offset).isActive = true
    }
    
    func pinRightToSuperview(offset: CGFloat = 0.0) {
        guard let superview = self.superview else {
            return
        }
        self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -offset).isActive = true
    }
    
    func pinTopToSuperview(offset: CGFloat = 0.0) {
        guard let superview = self.superview else {
            return
        }
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: offset).isActive = true
    }
    
    func pinBottomToSuperview(offset: CGFloat = 0.0) {
        guard let superview = self.superview else {
            return
        }
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -offset).isActive = true
    }
    
}
