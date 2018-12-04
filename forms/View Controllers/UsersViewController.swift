//
//  UsersViewController.swift
//  forms
//
//  Created by Макс on 03/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit
import Alamofire

class UsersViewController: UIViewController {
    
    let GET_ALL_USERS = "https://forms-auth-nightly.teh-lab.ru/rest/users?offset=0&limit=500"
    var all_users: NSArray = []
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    var headers: HTTPHeaders  = [:]
    
    @IBOutlet weak var usersTable: UITableView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            self.menuBarButton.target = self.revealViewController()
            self.menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        let defaultValues = UserDefaults.standard
        if let token = defaultValues.string(forKey: "token"){
            //setting the name to label
            headers = [
                "Authorization": token,
                "Accept": "application/json"
            ]
        }else{}
        Alamofire.request(GET_ALL_USERS, method: .get, encoding:JSONEncoding.default, headers: self.headers).validate().responseJSON
            {
                response in
                switch response.result {
                case .success:
                    guard let jsonArray = response.result.value as? NSArray else { return }
                    self.all_users = jsonArray.value(forKey: "username") as! NSArray
                case .failure(let error):
                    print(error)
                }
        }
    }


}
