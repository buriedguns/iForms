//
//  Attribute.swift
//  forms
//
//  Created by Макс on 21/01/2019.
//  Copyright © 2019 Макс. All rights reserved.
//

import Foundation
import SwiftyJSON

class Attribute {
    var internalCode: String?
    var displayName: String?
    var description: String?
    var displayOptions: [[String:Any]?] = []
    var validationOptions: [[String:Any]?] = []
    var id: String?
    
    init(json: JSON) {
        
        self.id = json["id"].string
        self.internalCode = json["internalCode"].string
        self.displayName = json["displayName"].string
        self.description = json["description"].string
        self.displayOptions = json["displayOptions"].arrayValue.map{$0.dictionaryObject}
        self.validationOptions = json["validationOptions"].arrayValue.map{$0.dictionaryObject}
        
    }
}
