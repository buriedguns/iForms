//
//  UsersTableViewController.swift
//  forms
//
//  Created by Макс on 04/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit
import Alamofire

class UsersTableViewController: UITableViewController {
    
    var newUser: String = ""
    var all_users = [User]()
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    var headers: HTTPHeaders  = [:]
    var rowIndex = 0
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidAppear(_ animated: Bool) {
        loadUsers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            self.menuBarButton.target = self.revealViewController()
            self.menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    func loadUsers() {
        self.all_users.removeAll()
            APIManager.shared.getAllUsers { (JSON) in
                if let tempUsers = JSON.array {
                    for i in tempUsers {
                        let user = User(json: i)
                        self.all_users.append(user)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    
    
    @IBAction func done(segue:UIStoryboardSegue) {
        Helpers.showActivityIndicator(self.activityIndicator, view)
        self.viewDidAppear(false)
        Helpers.hideActivityIndicator(self.activityIndicator)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addUserSegue"{
            let vc = segue.destination as? UserViewController
            vc?.currentTitle = "Add User"
        }
        if segue.identifier == "editUserSegue"{
            let vc = segue.destination as? UserViewController
            vc?.currentUser = self.all_users[tableView.indexPathForSelectedRow!.row]
            vc?.currentTitle = "Edit User"
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return all_users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = all_users[indexPath.row]
        
        cell.textLabel?.text = user.displayName
        
        return cell
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowIndex = indexPath.row
    }

}
