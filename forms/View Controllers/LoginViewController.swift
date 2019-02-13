//
//  ViewController.swift
//  forms
//
//  Created by Макс on 30/11/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class ViewController: UIViewController {
    
    //the default values to store user data
    let defaultValues = UserDefaults.standard
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusMessage: UILabel!
    let ut = UsersTableViewController()
    let group = DispatchGroup()
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        APIManager.shared.logIn(login: loginField.text!, password: passwordField.text!) { (error) in //login: loginField.text!, password: passwordField.text!
            
            if error != nil {
                self.statusMessage.isHidden = false
                self.statusMessage.text = "Wrong Login or Password!"
            } else {
                    self.performSegue(withIdentifier: "logInSegue", sender: self)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordField.isSecureTextEntry = true
        //hiding the navigation button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton      
        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
        if defaultValues.string(forKey: "username") != nil{
            let ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! SWRevealViewController
            self.navigationController?.pushViewController(ProfileViewController, animated: true)
            
        }
    }
}
