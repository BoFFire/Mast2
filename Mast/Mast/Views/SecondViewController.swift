//
//  SecondViewController.swift
//  Mast
//
//  Created by Shihab Mehboob on 11/09/2019.
//  Copyright © 2019 Shihab Mehboob. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    var tableView2 = UITableView()
    let segment: UISegmentedControl = UISegmentedControl(items: ["Activity".localized, "Metrics".localized])
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Table
        let tableHeight = (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + (self.navigationController?.navigationBar.bounds.height ?? 0) + (self.segment.bounds.height) + 10
        self.tableView.frame = CGRect(x: 0, y: tableHeight, width: self.view.bounds.width, height: (self.view.bounds.height) - tableHeight)
        self.tableView2.frame = CGRect(x: 0, y: tableHeight, width: self.view.bounds.width, height: (self.view.bounds.height) - tableHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "baseWhite")
        self.title = "Notifications".localized
        self.removeTabbarItemsText()
        
        // Segmented control
        self.segment.frame = CGRect(x: 15, y: (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + (self.navigationController?.navigationBar.bounds.height ?? 0) + 5, width: self.view.bounds.width - 30, height: segment.bounds.height)
        self.segment.selectedSegmentIndex = 0
        self.segment.addTarget(self, action: #selector(changeSegment(_:)), for: .valueChanged)
        self.view.addSubview(self.segment)

        // Add button
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 21, weight: .regular)
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(systemName: "plus", withConfiguration: symbolConfig)?.withTintColor(UIColor(named: "baseBlack")!.withAlphaComponent(1), renderingMode: .alwaysOriginal), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(self.addTapped), for: .touchUpInside)
        let addButton = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButton(addButton, animated: true)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(systemName: "arrow.up.arrow.down", withConfiguration: symbolConfig)?.withTintColor(UIColor(named: "baseBlack")!.withAlphaComponent(1), renderingMode: .alwaysOriginal), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(self.sortTapped), for: .touchUpInside)
        let settingsButton = UIBarButtonItem(customView: btn2)
        self.navigationItem.setLeftBarButton(settingsButton, animated: true)
        
        // Table
        self.tableView.register(NotificationsCell.self, forCellReuseIdentifier: "NotificationsCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor(named: "baseBlack")?.withAlphaComponent(0.24)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.layer.masksToBounds = true
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        self.tableView.reloadData()
        
        self.tableView2.register(DirectCell.self, forCellReuseIdentifier: "DirectCell")
        self.tableView2.delegate = self
        self.tableView2.dataSource = self
        self.tableView2.separatorStyle = .singleLine
        self.tableView2.separatorColor = UIColor(named: "baseBlack")?.withAlphaComponent(0.24)
        self.tableView2.backgroundColor = UIColor.clear
        self.tableView2.layer.masksToBounds = true
        self.tableView2.estimatedRowHeight = UITableView.automaticDimension
        self.tableView2.rowHeight = UITableView.automaticDimension
        self.tableView2.showsVerticalScrollIndicator = true
        self.tableView2.tableFooterView = UIView()
        self.tableView2.alpha = 0
        self.view.addSubview(self.tableView2)
        self.tableView2.reloadData()
    }
    
    @objc func changeSegment(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            self.tableView.alpha = 1
            self.tableView2.alpha = 0
            self.tableView.reloadData()
        }
        if segment.selectedSegmentIndex == 1 {
            self.tableView.alpha = 0
            self.tableView2.alpha = 1
            self.tableView2.reloadData()
        }
    }
    
    @objc func sortTapped() {
        
    }
    
    @objc func addTapped() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "addTapped"), object: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return GlobalStruct.notifications.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            if GlobalStruct.notifications.isEmpty {
                self.fetchNotifications()
                let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as! NotificationsCell
                cell.backgroundColor = UIColor(named: "baseWhite")
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsCell", for: indexPath) as! NotificationsCell
                cell.configure(GlobalStruct.notifications[indexPath.row])
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewProfile(_:)))
                cell.profile.tag = indexPath.row
                cell.profile.addGestureRecognizer(tap)
                let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.viewProfile2(_:)))
                cell.profile2.tag = indexPath.row
                cell.profile2.addGestureRecognizer(tap2)
                if indexPath.row == GlobalStruct.notifications.count - 10 {
                    self.fetchMoreNotifications()
                }
                cell.backgroundColor = UIColor(named: "baseWhite")
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DirectCell", for: indexPath) as! DirectCell
            
            cell.backgroundColor = UIColor(named: "baseWhite")
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = bgColorView
            return cell
        }
    }
    
    func fetchNotifications() {
        let request = Notifications.all(range: .default)
        GlobalStruct.client.run(request) { (statuses) in
            if let stat = (statuses.value) {
                DispatchQueue.main.async {
                    GlobalStruct.notifications = stat
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func fetchMoreNotifications() {
        let request = Notifications.all(range: .max(id: GlobalStruct.notifications.last?.id ?? "", limit: nil))
        GlobalStruct.client.run(request) { (statuses) in
            if let stat = (statuses.value) {
                if stat.isEmpty {} else {
                    DispatchQueue.main.async {
                        let indexPaths = ((GlobalStruct.notifications.count)..<(GlobalStruct.notifications.count + stat.count)).map {
                            IndexPath(row: $0, section: 0)
                        }
                        GlobalStruct.notifications.append(contentsOf: stat)
                        self.tableView.beginUpdates()
                        self.tableView.insertRows(at: indexPaths, with: UITableView.RowAnimation.none)
                        self.tableView.endUpdates()
                    }
                }
            }
        }
    }
    
    @objc func viewProfile(_ gesture: UIGestureRecognizer) {
        let vc = FifthViewController()
        vc.isYou = false
        if self.tableView.alpha == 1 {
            if let stat = GlobalStruct.notifications[gesture.view!.tag].status {
                vc.pickedCurrentUser = stat.account
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                vc.pickedCurrentUser = GlobalStruct.notifications[gesture.view!.tag].account
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @objc func viewProfile2(_ gesture: UIGestureRecognizer) {
        let vc = FifthViewController()
        vc.isYou = false
        vc.pickedCurrentUser = GlobalStruct.notifications[gesture.view!.tag].account
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == self.tableView {
            if GlobalStruct.notifications[indexPath.row].type == .direct {
                
            } else if GlobalStruct.notifications[indexPath.row].type == .follow {
                let vc = FifthViewController()
                vc.isYou = false
                vc.pickedCurrentUser = GlobalStruct.notifications[indexPath.row].account
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = DetailViewController()
                vc.pickedStatusesHome = [GlobalStruct.notifications[indexPath.row].status!]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            
        }
    }
    
    func removeTabbarItemsText() {
        if let items = self.tabBarController?.tabBar.items {
            for item in items {
                item.title = ""
            }
        }
    }
}
