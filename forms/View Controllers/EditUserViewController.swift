//
//  EditUserViewController.swift
//  forms
//
//  Created by Макс on 04/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit

class EditUserViewController: ViewController, UITextFieldDelegate {

    var newUserName: String = ""
    var newIdentificatorAD: String = ""
    var newFullName: String = ""
    var newEMail: String = ""
    var newPermissions : Array = [String] ()
    var newGroups: Array = [String] ()
    var newDepartment : String = ""
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var identificatorAD: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var eMail: UITextField!
    @IBOutlet var permissions: [UITextField]!
    @IBOutlet var groups: [UITextField]!
    @IBOutlet weak var department: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            
            performSegue(withIdentifier: "groupSegue", sender: self)
            
            return false
        }
    }
    @IBAction func cancel(segue:UIStoryboardSegue) {
    }
    @IBAction func done(segue:UIStoryboardSegue) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            if let un = userName.text{
                newUserName = un
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
            if permissions.count > 0{
                for i in permissions{
                    newPermissions.append(i.text!)
                }
            }
            if groups.count > 0 {
                for i in groups{
                    newGroups.append(i.text!)
                }
            }
            if let department = department.text{
                newDepartment = department
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
