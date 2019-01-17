//
//  Group.swift
//  forms
//
//  Created by Макс on 17/01/2019.
//  Copyright © 2019 Макс. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON

class Group {
    var id: String?
    var name: String?
    var displayName: String?
    var permissions: [String?]
    
    init(json: JSON) {
        
        self.id = json["id"].string
        self.name = json["name"].string
        self.displayName = json["displayName"].string
        self.permissions = json["permissions"].arrayValue.map{ $0.stringValue }
        
    }
}
