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
    let GET_ALL_USERS = "https://forms-auth-nightly.teh-lab.ru/rest/users?offset=0&limit=500"
    var all_users = [User]()
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    var headers: HTTPHeaders  = [:]
    var rowIndex = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            self.menuBarButton.target = self.revealViewController()
            self.menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        loadUsers()
    }
    
    func loadUsers() {
        APIManager.shared.getAllUsers { (JSON) in
            self.all_users = []
            if let tempUsers = JSON.array {
                for i in tempUsers {
                    let user = User(json: i)
                    self.all_users.append(user)
                }
                self.tableView.reloadData()
            }
            print(self.all_users)
        }
    }
    
    /*func getAllUsers() {
        let defaultValues = UserDefaults.standard
        if let token = defaultValues.string(forKey: "token"){
            headers = [
                "Authorization": token,
                "Accept": "application/json"
            ]
        }else{
            
        }
        Alamofire.request(GET_ALL_USERS, method: .get, encoding:JSONEncoding.default, headers: self.headers).validate().responseJSON
            {
                response in
                switch response.result {
                case .success:
                    guard let jsonArray = response.result.value as? NSArray else { return }
                    self.all_users = (jsonArray.value(forKey: "username") as! NSArray) as! Array<String>
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
        }
        
    }*/
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    @IBAction func done(segue:UIStoryboardSegue) {
        
    }

    
   /* @IBAction func done(segue:UIStoryboardSegue) {
        let userDetailVC = segue.source as! EditUserViewController
        newUser = userDetailVC.newUserName
        all_users.append(newUser)
        tableView.reloadData()
        } */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addUserSegue"{
            let vc = segue.destination as? EditUserViewController
            vc?.currentTitle = "Add User"
        }
        if segue.identifier == "editUserSegue"{
            let vc = segue.destination as? EditUserViewController
            vc?.currentUser = self.all_users[tableView.indexPathForSelectedRow!.row]
            let uN = vc!.currentUser!.displayName!
            print(uN)
            vc?.currentTitle = "Edit User"
            vc?.userName.text = "Бабущка"
        }
    }
        

    // MARK: - Table view data source

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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
