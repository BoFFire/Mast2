//
//  FifthViewController.swift
//  Mast
//
//  Created by Shihab Mehboob on 11/09/2019.
//  Copyright © 2019 Shihab Mehboob. All rights reserved.
//

import Foundation
import UIKit

class FifthViewController: UIViewController {
    
    var isYou = true
    var pickedCurrentUser: Account!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "baseWhite")
        self.title = "Profile".localized
        self.removeTabbarItemsText()

        // Add button
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 21, weight: .regular)
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(systemName: "plus", withConfiguration: symbolConfig)?.withTintColor(UIColor(named: "baseBlack")!.withAlphaComponent(1), renderingMode: .alwaysOriginal), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.addTapped), for: .touchUpInside)
        let addButton = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButton(addButton, animated: true)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(systemName: "gear", withConfiguration: symbolConfig)?.withTintColor(UIColor(named: "baseBlack")!.withAlphaComponent(1), renderingMode: .alwaysOriginal), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(self.settingsTapped), for: .touchUpInside)
        let settingsButton = UIBarButtonItem(customView: btn2)
        if self.isYou {
            self.navigationItem.setLeftBarButton(settingsButton, animated: true)
        }
    }
    
    @objc func settingsTapped() {
        self.show(UINavigationController(rootViewController: SettingsViewController()), sender: self)
    }
    
    @objc func addTapped() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "addTapped"), object: self)
    }
    
    func removeTabbarItemsText() {
        if let items = self.tabBarController?.tabBar.items {
            for item in items {
                item.title = ""
            }
        }
    }
}
