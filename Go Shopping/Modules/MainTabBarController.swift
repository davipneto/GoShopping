//
//  MainTabBarController.swift
//  Go Shopping
//
//  Created by Davi Pereira Neto on 01/02/19.
//  Copyright © 2019 Davi Pereira Neto. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBar.isHidden = false
    }

}
