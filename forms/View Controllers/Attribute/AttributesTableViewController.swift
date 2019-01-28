//
//  AttributesTableViewController.swift
//  forms
//
//  Created by Макс on 21/01/2019.
//  Copyright © 2019 Макс. All rights reserved.
//

import UIKit

class AttributesTableViewController: UITableViewController {

    
    var allAttributes = [Attribute]()
    var rowIndex = 0
    
    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    override func viewDidAppear(_ animated: Bool) {
        loadAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            self.menuBarButton.target = self.revealViewController()
            self.menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func loadAttributes() {
        
        self.allAttributes.removeAll()
        APIManager.shared.getAllAttributes { (JSON) in
            let JSON = JSON["entities"]
            if let tempAttributes = JSON.array {
                for i in tempAttributes{
                    let attribute = Attribute(json: i)
                    self.allAttributes.append(attribute)
                }
                self.tableView.reloadData()
            }
        }
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroupSegue"{
            let vc = segue.destination as? AttributeViewController
            vc?.currentTitle = "Add Group"
        }
        if segue.identifier == "editGroupSegue"{
            let vc = segue.destination as? AttributeViewController
            vc?.currentGroup = self.allAttributes[tableView.indexPathForSelectedRow!.row]
            vc?.currentTitle = "Edit Group"
        }
    }
    */
    @IBAction func cancelAttributeCreation(segue: UIStoryboardSegue){
        self.tableView.reloadData()
    }
    
    @IBAction func doneAttributeCreation(segue: UIStoryboardSegue){
        self.viewDidAppear(false)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allAttributes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attributeCell", for: indexPath)
        let attribute = allAttributes[indexPath.row]
        cell.textLabel?.text = attribute.displayName
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowIndex = indexPath.row
    }
    

}
