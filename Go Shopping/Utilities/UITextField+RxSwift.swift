//
//  UITextField+RxSwift.swift
//  Go Shopping
//
//  Created by Davi Pereira Neto on 07/02/19.
//  Copyright © 2019 Davi Pereira Neto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {

    public var editingDidBegin: ControlEvent<()> {
        return base.rx.controlEvent(UIControlEvents.editingDidBegin)
    }
    
    public var editingDidEnd: ControlEvent<()> {
        return base.rx.controlEvent(UIControlEvents.editingDidEnd)
    }
}
