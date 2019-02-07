//
//  ViewController.swift
//  Go Shopping
//
//  Created by Davi Pereira Neto on 30/01/19.
//  Copyright © 2019 Davi Pereira Neto. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = ListViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureTableView()
        configureToolbar()
        configureTabBar()
    }
    
    private func configureNavigationItems() {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 22
        
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: ListItemTableViewCell.identifier, cellType: ListItemTableViewCell.self)) {
                (index, item, cell) in
                cell.item = item
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemInserted
            .bind { indexPath in
                self.addItem()
            }
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(onNext: { index in
                self.viewModel.newItemSelected(index)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeselected
            .map { $0.row }
            .bind(onNext: { index in self.viewModel.newItemDelesected(index)
            })
            .disposed(by: disposeBag)
    }
    
    func configureToolbar() {
        let completeButton = UIBarButtonItem(title: "Complete", style: .plain, target: self, action: #selector(self.completeItems))
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let deleteButton = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(self.deleteItems))
        
        let areThereItemsSelected = viewModel.itemsSelected.map { $0.count > 0 }
        
        areThereItemsSelected
            .bind(to: deleteButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        areThereItemsSelected
            .map { $0 ? "Complete" : "Complete All" }
            .bind(to: completeButton.rx.title)
            .disposed(by: disposeBag)
        
        self.setToolbarItems([completeButton, spaceItem, deleteButton], animated: false)
    }
    
    private func configureTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
        self.tabBarController?.tabBar.isHidden = editing
        if !editing {
            self.viewModel.finishEditing()
        }
    }
    
    @objc func completeItems() {
        print("completou")
    }
    
    @objc func deleteItems() {
        print("Deletou")
    }
    
    private func addItem() {
        print("item added")
    }

}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if viewModel.isLastItem(indexPath.row) {
            return false
        }
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if viewModel.isLastItem(indexPath.row) {
            return UITableViewCell.EditingStyle.insert
        }
        return UITableViewCell.EditingStyle(rawValue: UITableViewCell.EditingStyle.insert.rawValue | UITableViewCell.EditingStyle.delete.rawValue)!
    }
    
}
