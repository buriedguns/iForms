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
    
    let URL_USER_LOGIN = "https://forms-auth-nightly.teh-lab.ru/auth"
    
    //the default values to store user data
    let defaultValues = UserDefaults.standard
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusMessage: UILabel!
    @IBAction func loginButton(_ sender: UIButton) {
        
        //getting the username and password
        let parameters: Parameters=[
            "login":loginField.text!,
            "password":passwordField.text!
        ]
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters, encoding:
            JSONEncoding.default).validate().responseJSON
            {
                response in
                //printing response
                switch response.result {
                case .success:
                    self.statusMessage.text = "pass!"
                    guard let jsonArray = response.result.value as? NSDictionary else { return }
                    let user = jsonArray.value(forKey: "user") as! NSDictionary
                    let token = jsonArray["token"] as! String
                    let userName = user.value(forKey: "username") as! String
                    self.defaultValues.set(token, forKey: "token")
                    self.defaultValues.set(userName, forKey: "username")
                    self.performSegue(withIdentifier: "logInSegue", sender: self)
                case .failure(let error):
                    self.statusMessage.text = "bad!"
                    print(error)
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
            let ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! SWRevealViewController
            self.navigationController?.pushViewController(ProfileViewController, animated: true)
            
        }
    }
}
