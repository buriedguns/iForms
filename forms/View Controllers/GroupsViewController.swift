//
//  GroupsViewController.swift
//  forms
//
//  Created by Макс on 03/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    var allGroups = [Group]()
    var rowIndex = 0

    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            self.menuBarButton.target = self.revealViewController()
            self.menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        loadGroups()
    }
    
    func loadGroups() {
        
        self.allGroups.removeAll()
        APIManager.shared.getAllGroups { (JSON) in
            if let tempGroups = JSON.array {
                for i in tempGroups {
                    let group = Group(json: i)
                    self.allGroups.append(group)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = allGroups[indexPath.row]
        
        cell.textLabel?.text = group.displayName
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowIndex = indexPath.row
    }
    
}

