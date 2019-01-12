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
    var currentUser: User?
    
    @IBOutlet weak var customUserTitle: UINavigationItem!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var identificatorAD: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var eMail: UITextField!
    @IBOutlet var permissions: [UITextField]!
    @IBOutlet var groups: [UITextField]!
    @IBOutlet weak var department: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultValues = UserDefaults.standard
        if let token = defaultValues.string(forKey: "token"){
            print(self.permissions)
            headers = [
                "Authorization": token,
                "Accept": "application/json"
            ]
        }
        switch currentTitle {
        case "Add User":
            self.customUserTitle.title = currentTitle
        case "Edit User":
            self.customUserTitle.title = currentTitle
        default:
            print("!")
        }
    }
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    @IBAction func done(segue:UIStoryboardSegue) {

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            if let userName = userName.text{
                newUserName = userName
            }
            if let id = identificatorAD.text {
                newIdentificatorAD = id
            }
            if let fullName = fullName.text{
                newFullName = fullName
            }
            if let eMail = eMail.text{
                newEMail = eMail
            }
            for i in permissions{
                if i.text! != ""{
                    newPermissions.append(i.text!)
                }
            }
            for i in groups{
                if i.text! != ""{
                    newGroups.append(i.text!)
                }
            }
            if let department = department.text{
                newDepartment = department
            }
            
            let parameters: [String : Any] = ["username":self.newFullName,
                                              "permissions": self.newPermissions,
                                              "groups": self.newGroups,
                                              "ldapId": self.newIdentificatorAD,
                                              "displayName": self.newFullName,
                                              "departamentDisplayName": self.newDepartment,
                                              "mail": self.newEMail]
            print(parameters)
            Alamofire.request(self.CREATE_USER_URL, method: .post, parameters: parameters, encoding:
                JSONEncoding.default, headers: headers).responseString
                {
                    response in
                    print(response)
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
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
