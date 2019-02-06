//
//  ListViewModel.swift
//  Go Shopping
//
//  Created by Davi Pereira Neto on 05/02/19.
//  Copyright © 2019 Davi Pereira Neto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel: NSObject {
    
    let itemsSelected = BehaviorRelay<[Int]>(value: [])
    
    func addItemSelected(_ item: Int) {
        itemsSelected.accept(itemsSelected.value + [item])
    }
    
    func removeItemDelesected(_ item: Int) {
        var items = itemsSelected.value
        items.removeAll { $0 == item }
        itemsSelected.accept(items)
    }
    
    func removeAllItemsSelected() {
        itemsSelected.accept([])
    }
    
}
