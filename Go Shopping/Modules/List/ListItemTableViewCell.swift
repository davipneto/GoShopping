//
//  ListItemTableViewCell.swift
//  Go Shopping
//
//  Created by Davi Pereira Neto on 31/01/19.
//  Copyright © 2019 Davi Pereira Neto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    static let identifier = "ListItemCell"
    let disposeBag = DisposeBag()
    let isEditingItem = BehaviorRelay<Bool>(value: false)
    let title = BehaviorRelay<String>(value: "")
    let isCellExpanded = BehaviorRelay<Bool>(value: false)
    var item: ListItem? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        if let item = self.item {
            titleLabel.text = item.title
            titleLabel.textColor = UIColor.listItemExplicit
        } else {
            titleLabel.text = "Add Item"
            titleLabel.textColor = UIColor.listItemHidden
        }
        bind()
    }
    
    private func bind() {
        if item == nil {
            titleTextField.rx.editingDidBegin
                .bind { self.isEditingItem.accept(true) }
                .disposed(by: disposeBag)
            
            titleTextField.rx.editingDidEnd
                .bind { self.isEditingItem.accept(false) }
                .disposed(by: disposeBag)
            
            isEditingItem
                .bind(to: self.titleLabel.rx.isHidden)
                .disposed(by: disposeBag)
            
            titleTextField.rx.text
                .orEmpty
                .bind(to: self.title)
                .disposed(by: disposeBag)
            
            title
                .map { $0 != "" }
                .bind(to: self.isCellExpanded)
                .disposed(by: disposeBag)
            
            isCellExpanded
                .bind { print($0) }
                .disposed(by: disposeBag)
        } else {
            titleTextField.isEnabled = false
        }
    }

}
