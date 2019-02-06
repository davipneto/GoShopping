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
    let notes = [
        "Eh isto",
        "Novamente"
    ]
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        configureTableView()
        configureToolbar()
        configureTabBar()
        bind()

    }
    
    private func configureNavigationItems() {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 22
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
    
    private func bind() {
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(onNext: { index in
                self.viewModel.addItemSelected(index)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeselected
            .map { $0.row }
            .bind(onNext: { index in self.viewModel.removeItemDelesected(index)
            })
            .disposed(by: disposeBag)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
        self.tabBarController?.tabBar.isHidden = editing
        if !editing {
            self.viewModel.removeAllItemsSelected()
        }
    }
    
    @objc func completeItems() {
        print("completou")
    }
    
    @objc func deleteItems() {
        print("Deletou")
    }
    
    private func addItem() {
        
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.identifier) as! ListItemTableViewCell
        let row = indexPath.row
        let textLabel = cell.textLabel
        let imageView = cell.imageView
        if row == notes.count {
            textLabel?.text = "Add Item"
            textLabel?.textColor = UIColor.listItemHidden
            imageView?.image = R.image.plus()
            cell.accessoryType = .none
        } else {
            textLabel?.text = notes[row]
            textLabel?.textColor = UIColor.listItemExplicit
            imageView?.image = nil
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == notes.count {
            addItem()
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert {
            addItem()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == notes.count {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.imageView?.image = nil
            return UITableViewCell.EditingStyle.insert
        }
        return UITableViewCell.EditingStyle(rawValue: UITableViewCell.EditingStyle.insert.rawValue | UITableViewCell.EditingStyle.delete.rawValue)!
    }
    
}
