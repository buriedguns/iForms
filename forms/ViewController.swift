//
//  ViewController.swift
//  forms
//
//  Created by Макс on 30/11/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let URL_USER_LOGIN = "https://forms-auth-nightly.teh-lab.ru/auth"
    
    //the default values to store user data
    let defaultValues = UserDefaults.standard
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusMessage: UILabel!
    @IBAction func loginButton(_ sender: UIButton) {
        
        //getting the username and password
        let parameters: Parameters=[
            "username":loginField.text!,
            "password":passwordField.text!
        ]
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters, encoding:
            JSONEncoding.default).responseString
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userId = user.value(forKey: "id") as! Int
                        let userName = user.value(forKey: "username") as! String
                        let userEmail = user.value(forKey: "email") as! String
                        let userPhone = user.value(forKey: "phone") as! String
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        self.defaultValues.set(userPhone, forKey: "userphone")
                        
                        //switching the screen
                        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
                        self.navigationController?.pushViewController(profileViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        self.statusMessage.text = "Invalid username or password"
                    }
                }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding the navigation button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
        if defaultValues.string(forKey: "username") != nil{
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
            self.navigationController?.pushViewController(profileViewController, animated: true)
            
        }
    }
}

