//
//  CustomSelectorTableViewController.swift
//  forms
//
//  Created by Макс on 04/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit
import Alamofire

class CustomSelectorTableViewController: UsersTableViewController {
    
    var currentTitle = ""
    var URLS = ["https://forms-auth-nightly.teh-lab.ru/rest/groups?offset=0&limit=500",]
    
    @IBOutlet weak var customSelectorTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch currentTitle {
        case "Groups":
            var all_groups = [String:String]()
            self.customSelectorTitle.title = currentTitle
            Alamofire.request(URLS[0], method: .get, encoding:JSONEncoding.default, headers: self.headers).validate().responseJSON
                {
                    response in
                    switch response.result {
                    case .success:
                        guard let jsonArray = response.result.value as? NSArray else { return }
                        let group_ids = jsonArray.value(forKey: "id") as! NSArray as! Array<String>
                        let group_names = jsonArray.value(forKey: "displayName") as! NSArray as! Array<String>
                        for (i, y) in zip(group_ids, group_names) {
                            all_groups[y] = i
                        }
                        print(all_groups)
                        self.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
            }
        case "Permissions":
            print("HEY")
        default:
            print("!")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
