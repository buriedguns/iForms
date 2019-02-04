//
//  GroupViewController.swift
//  forms
//
//  Created by Макс on 21/01/2019.
//  Copyright © 2019 Макс. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITextFieldDelegate {

    var currentTitle = ""
    var isGroupChanged = false
    var currentGroup: Group?
    let activityIndicator = UIActivityIndicatorView()
    
    
    @IBOutlet weak var customGroupTitle: UINavigationItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var displayName: UITextField!
    @IBOutlet weak var permissions: UITextField!
    
    @IBAction func requiredFieldsAreEmpty(_ sender: UITextField) {
        if name.text!.isEmpty || displayName.text!.isEmpty {
            self.doneButton.isEnabled = false
        } else {
            self.doneButton.isEnabled = true
        }
    }
    
    @IBAction func isNameIsEmpty(_ sender: UITextField) {
        if let text = sender.text {
            if text.isEmpty {
                self.name.layer.borderColor = UIColor.red.cgColor
                self.name.layer.borderWidth = 1.0
            } else {
                self.name.layer.borderWidth = 0
            }
        }
    }
    
    @IBAction func isDisplayNameIsEmpty(_ sender: UITextField) {
        if let text = sender.text {
            if text.isEmpty {
                self.displayName.layer.borderColor = UIColor.red.cgColor
                self.displayName.layer.borderWidth = 1.0
            } else {
                self.displayName.layer.borderWidth = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customGroupTitle.title = currentTitle
        if currentTitle == "Edit Group" {
            setCurrentUserDataToTextFields()
            self.name.isEnabled = false
            self.name.textColor = UIColor.gray
        } else if currentTitle == "Add Group" {
            self.name.isEnabled = true
            self.doneButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Editing Group
        isThereNewData()
        if segue.identifier == "doneSegue" && currentTitle == "Edit Group" {
            if self.isGroupChanged == true{
                let parameters: [String : Any] = ["displayName": self.displayName.text!]
                APIManager.shared.editGroup((currentGroup?.name)!, parameters) { JSON in
                    print(JSON)
                }
            }
        } // Adding Group
        else if segue.identifier == "doneSegue" && currentTitle == "Add Group" {
            let parameters: [String : Any] = ["name": self.name.text!,
                                              "displayName": self.displayName.text!]
            APIManager.shared.createGroup(parameters) { JSON in
            }
        }
        if segue.identifier == "groupSegue"{
            let vc = segue.destination as? CustomSelectorTableViewController
            vc?.currentTitle = "Groups"
        }
        if segue.identifier == "permissionSegue"{
            let vc = segue.destination as? CustomSelectorTableViewController
            vc?.currentTitle = "Permissions"
        }
    }
    
    
    func setCurrentUserDataToTextFields() {
        self.name.text = currentGroup?.name
        self.displayName.text = currentGroup?.displayName
    }
    
    func isThereNewData() {
        if  currentGroup?.displayName == self.displayName.text{
            self.isGroupChanged = false
        } else {
            self.isGroupChanged = true
        }
    }
}
