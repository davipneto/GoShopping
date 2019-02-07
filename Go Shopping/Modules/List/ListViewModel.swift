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
    
    let items = BehaviorRelay<[ListItem?]>(value: [
            ListItem(title: "Teste 1"),
            ListItem(title: "Teste 2"),
            nil
        ])
    let itemsSelected = BehaviorRelay<[Int]>(value: [])
    
    func isLastItem(_ index: Int) -> Bool {
        return index == items.value.count - 1
    }
    
    func addItem() {
        
    }
    
    func newItemSelected(_ index: Int) {
        itemsSelected.accept(itemsSelected.value + [index])
    }
    
    func newItemDelesected(_ index: Int) {
        var items = itemsSelected.value
        items.removeAll { $0 == index }
        itemsSelected.accept(items)
    }
    
    func finishEditing() {
        itemsSelected.accept([])
    }
    
}
