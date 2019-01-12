//
//  User.swift
//  forms
//
//  Created by Макс on 29/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var id: String?
    var userName: String?
    var displayName: String?
    var departmentDisplayName: String?
    var mail: String?
    var ldapId: String?
    var permissions: [String?]
    var groups: [String?]
    
    init(json: JSON) {
        
        self.id = json["id"].string
        self.userName = json["username"].string
        self.displayName = json["displayName"].string
        self.departmentDisplayName = json["departamentDisplayName"].string
        self.mail = json["mail"].string
        self.ldapId = json["ldapId"].string
        self.permissions = json["permissions"].arrayValue.map{ $0.stringValue }
        self.groups = json["groups"].arrayValue.map{ $0.stringValue }
        
    }
}
