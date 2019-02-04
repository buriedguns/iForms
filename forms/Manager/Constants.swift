//
//  Constants.swift
//  forms
//
//  Created by Макс on 29/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import Foundation

// use for auth, users and groups
let AUTH_BASE_URL: String = "https://forms-auth-nightly.teh-lab.ru"
// use for getting objects, object types and attribute types
let DATA_BASE_URL: String = "https://forms-objects-metadata-nightly.teh-lab.ru"

let BASE_TYPES: [(appName: String, requestName: String)] = [("Строка", "string"), ("Булево", "boolean"), ("Ссылка на объект", "objectReference")]
