//
//  ListItemTableViewCell.swift
//  Go Shopping
//
//  Created by Davi Pereira Neto on 31/01/19.
//  Copyright © 2019 Davi Pereira Neto. All rights reserved.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    static let identifier = "ListItemCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindEditing() {
        
    }

}
