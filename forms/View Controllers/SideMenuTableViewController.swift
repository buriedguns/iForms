//
//  SideMenuTableViewController.swift
//  forms
//
//  Created by Макс on 03/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    @IBOutlet weak var userName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "username"){
            //setting the name to label
            self.userName.text = name
        }else{
            //send back to login view controller
        }
    }

}
