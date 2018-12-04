//
//  GroupsViewController.swift
//  forms
//
//  Created by Макс on 03/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {

    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            self.menuBarButton.target = self.revealViewController()
            self.menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}
