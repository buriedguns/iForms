//
//  Helper.swift
//  forms
//
//  Created by Макс on 16/01/2019.
//  Copyright © 2019 Макс. All rights reserved.
//

import Foundation

class Helpers {
    // Helper method to show activity indicator
    static func showActivityIndicator(_ activityIndicator: UIActivityIndicatorView,_ view: UIView){
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = UIColor.black
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    // Helper method to hide activity indicator
    static func hideActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
    }
}
