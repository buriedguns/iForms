//
//  EditUserViewController.swift
//  forms
//
//  Created by Макс on 04/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserViewController: UIViewController, UITextFieldDelegate {
    
    var currentTitle = ""
    var isUserChanged = false
    var currentUser: User?
    let activityIndicator = UIActivityIndicatorView()
    
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var customUserTitle: UINavigationItem!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var identificatorAD: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var eMail: UITextField!
    @IBOutlet var permissions: [UITextField]!
    @IBOutlet var groups: [UITextField]!
    @IBOutlet weak var department: UITextField!
    @IBOutlet weak var localPassword: UITextField!
    @IBOutlet weak var passwordConfirmation: UITextField!
    
    
    @IBAction func requiredFieldsAreEmpty(_ sender: UITextField) {
        if userName.text!.isEmpty || fullName.text!.isEmpty || eMail.text!.isEmpty{
            self.doneButton.isEnabled = false
        } else {
            self.doneButton.isEnabled = true
        }
    }
    
    @IBAction func userNameHasBeenChanged(_ sender: UITextField) {
        if let text = sender.text {
            if text.isEmpty {
                self.userName.layer.borderColor = UIColor.red.cgColor
                self.userName.layer.borderWidth = 1.0
            } else {
                self.userName.layer.borderWidth = 0
            }
        }
    }
    
    @IBAction func displayNameHasBeenChanged(_ sender: UITextField) {
        if let text = sender.text {
            if text.isEmpty {
                self.fullName.layer.borderColor = UIColor.red.cgColor
                self.fullName.layer.borderWidth = 1.0
            } else {
                self.fullName.layer.borderWidth = 0
            }
        }
    }
    
    @IBAction func emailHasBeenChanged(_ sender: UITextField) {
        if let text = sender.text {
            if text.isEmpty{
                self.eMail.layer.borderColor = UIColor.red.cgColor
                self.eMail.layer.borderWidth = 1.0
            } else {
                self.eMail.layer.borderWidth = 0
            }
        }
    }
    @IBAction func identificatorNotEmpty(_ sender: Any) {
        if self.identificatorAD.text?.isEmpty == true{
            self.localPassword.isHidden = false
            self.passwordConfirmation.isHidden = false
        } else {
            self.localPassword.isHidden = true
            self.passwordConfirmation.isHidden = true
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customUserTitle.title = currentTitle
        if currentTitle == "Edit User" {
            setCurrentUserDataToTextFields()
            self.userName.isEnabled = false
            self.userName.textColor = UIColor.gray
        } else if currentTitle == "Add User" {
            self.userName.isEnabled = true
            self.doneButton.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        isThereNewData()
        if segue.identifier == "doneSegue" && currentTitle == "Edit User" {
            if self.isUserChanged == true{
                let parameters: [String : Any] = ["ldapId": self.identificatorAD.text!,
                                                  "displayName": self.fullName.text!,
                                                  "departamentDisplayName": self.department.text!,
                                                  "mail": self.eMail.text!]
                APIManager.shared.editUser((currentUser?.userName)!, parameters) { JSON in
                }
            }
        } else if segue.identifier == "doneSegue" && currentTitle == "Add User" {
            let parameters: [String : Any] = ["username": self.userName.text!,
                                              "ldapId": self.identificatorAD.text!,
                                              "displayName": self.fullName.text!,
                                              "departamentDisplayName": self.department.text!,
                                              "mail": self.eMail.text!]
            APIManager.shared.createUser(parameters) { JSON in
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
        self.userName.text = currentUser?.userName
        self.identificatorAD.text = currentUser?.ldapId
        self.fullName.text = currentUser?.displayName
        self.eMail.text = currentUser?.mail
        self.department.text = currentUser?.departmentDisplayName
    }
    
    func isThereNewData() {
        if currentUser?.ldapId == self.identificatorAD.text &&
            currentUser?.displayName == self.fullName.text &&
            currentUser?.mail == self.eMail.text &&
            currentUser?.departmentDisplayName == self.department.text {
            self.isUserChanged = false
        } else {
            self.isUserChanged = true
        }
    }
}
