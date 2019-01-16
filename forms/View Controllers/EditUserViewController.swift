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

class EditUserViewController: UIViewController, UITextFieldDelegate {
    
    var currentTitle = ""
    var headers: HTTPHeaders  = [:]
    let CREATE_USER_URL = "https://forms-auth-nightly.teh-lab.ru/rest/users"
    var newIdentificatorAD: String = ""
    var newFullName: String = ""
    var newEMail: String = ""
    var newPermissions = [String]()
    var newGroups = [String]()
    var newDepartment : String = ""
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
    
    /*@IBAction func userNameHasBeenChanged(_ sender: UITextField) {
        if let text = sender.text {
            if text.count < 1 {
                self.userName.layer.borderColor = UIColor.red.cgColor
                self.userName.layer.borderWidth = 1.0
            } else {
                self.userName.layer.borderWidth = 0
                self.newUserName = sender.text!
                self.isUserChanged = true
            }
        }
    }*/
    
    @IBAction func ldapIdHasChanged(_ sender: UITextField) {
        self.newIdentificatorAD = sender.text!
        self.isUserChanged = true
    }
    
    @IBAction func displayNameHasBeenChanged(_ sender: UITextField) {
        if let text = sender.text {
            if text.count < 1 {
                self.fullName.layer.borderColor = UIColor.red.cgColor
                self.fullName.layer.borderWidth = 1.0
                self.doneButton.isEnabled = false
            } else {
                self.doneButton.isEnabled = true
                self.fullName.layer.borderWidth = 0
                self.newFullName = sender.text!
                self.isUserChanged = true
            }
        }
    }
    
    @IBAction func emailHasBeenChanged(_ sender: UITextField) {
        if let text = sender.text {
            if text.count < 1 {
                self.eMail.layer.borderColor = UIColor.red.cgColor
                self.eMail.layer.borderWidth = 1.0
                self.doneButton.isEnabled = false
            } else {
                self.doneButton.isEnabled = true
                self.eMail.layer.borderWidth = 0
                self.newEMail = sender.text!
                self.isUserChanged = true
            }
        }
    }
    
    @IBAction func departmentHasBeenChanged(_ sender: UITextField) {
        self.newDepartment = sender.text!
        self.isUserChanged = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentUserDataToTextFields()
        self.userName.isEnabled = false
        self.userName.textColor = UIColor.gray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        isThereNewData()
        if segue.identifier == "doneSegue" {
            if self.isUserChanged == true{
                let parameters: [String : Any] = ["ldapId": self.identificatorAD.text!,
                                                  "displayName": self.fullName.text!,
                                                  "departamentDisplayName": self.department.text!,
                                                  "mail": self.eMail.text!]
                
                APIManager.shared.editUser((currentUser?.userName)!, parameters) { JSON in
                }
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
        self.customUserTitle.title = currentTitle
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
