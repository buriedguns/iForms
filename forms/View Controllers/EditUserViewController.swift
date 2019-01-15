//
//  EditUserViewController.swift
//  forms
//
//  Created by Макс on 04/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit
import Alamofire

class EditUserViewController: ViewController, UITextFieldDelegate {
    
    var currentTitle = ""
    var headers: HTTPHeaders  = [:]
    let CREATE_USER_URL = "https://forms-auth-nightly.teh-lab.ru/rest/users"
    var newUserName: String = ""
    var newIdentificatorAD: String = ""
    var newFullName: String = ""
    var newEMail: String = ""
    var newPermissions = [String]()
    var newGroups = [String]()
    var newDepartment : String = ""
    var isUserChanged = false
    var currentUser: User?
    
    
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
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue, sender: Any) {
        
    }
    
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
        setCurrentUserDataToTextFields()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.isEnabled = false
        self.userName.textColor = UIColor.gray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        isThereNewData()
        if segue.identifier == "doneSegue" {
            if self.isUserChanged == false{
                print("Data isn't changed")
                //performSegue(withIdentifier: "doneSegue", sender: self)
            } else {
                print("Data Changed!")
            }
            
            /*let parameters: [String : Any] = ["username":self.newFullName,
                                              "permissions": self.newPermissions,
                                              "groups": self.newGroups,
                                              "ldapId": self.newIdentificatorAD,
                                              "displayName": self.newFullName,
                                              "departamentDisplayName": self.newDepartment,
                                              "mail": self.newEMail]
            Alamofire.request(self.CREATE_USER_URL, method: .post, parameters: parameters, encoding:
                JSONEncoding.default, headers: headers).responseString
                {
                    response in
            }*/
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
        if currentUser?.userName == self.userName.text &&
            currentUser?.ldapId == self.identificatorAD.text &&
            currentUser?.displayName == self.fullName.text &&
            currentUser?.mail == self.eMail.text &&
            currentUser?.departmentDisplayName == self.department.text {
            self.isUserChanged = false
        } else {
            self.isUserChanged = true
        }
        print("Check is complete!")
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //deprecated
    /*let defaultValues = UserDefaults.standard
     if let token = defaultValues.string(forKey: "token"){
     headers = [
     "Authorization": token,
     "Accept": "application/json"
     ]
     }*/
}
