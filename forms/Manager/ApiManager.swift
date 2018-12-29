//
//  ApiManager.swift
//  forms
//
//  Created by Макс on 29/12/2018.
//  Copyright © 2018 Макс. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    static let shared = APIManager()
    let dataBaseURL = NSURL(string: DATA_BASE_URL)
    let authBaseURL = NSURL(string: AUTH_BASE_URL)
    var accessToken = ""
    var headers: HTTPHeaders  = [:]
    //var expired = Date()
    
    func logIn(login: String, password: String, completionHandler: @escaping(NSError?) -> Void) -> Void {
        
        let path = "/auth"
        let url = authBaseURL!.appendingPathComponent(path)
        let params: Parameters = [
            "login": login,
            "password": password
        ]
        
        Alamofire.request(url!, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseJSON
            {
                response in
                switch response.result {
                case .success(let value):
                    let jsonData = JSON(value)
                    self.accessToken = jsonData["token"].string!
                    
                    completionHandler(nil)
                case .failure(let error):
                    completionHandler(error as NSError?)
                }
        }
    }
    
    func requestServer(_ metaDataBaseURL: Bool, _ method: HTTPMethod, _ path: String, params: [String: Any]?, _ encoding: ParameterEncoding,_ completionHandler: @escaping(JSON) -> Void) {
        
        var url: URL?
        
        if metaDataBaseURL == true {
            url = dataBaseURL!.appendingPathComponent(path)
        }else{
            url = authBaseURL!.appendingPathComponent(path)
        }
        
            Alamofire.request(url!, method: method, parameters: params, encoding: encoding, headers: headers).responseJSON{ response in
                
                switch response.result {
                case .success(let value):
                    let jsonData = JSON(value)
                    completionHandler(jsonData)
                    break
                case .failure:
                    break
                }
            }
        }
    
    func getAllUsers( completionHandler: @escaping(JSON) -> Void) {
        let path = "/rest/users?offset=0&limit=500"
        requestServer(false, .get, path, params: nil, JSONEncoding.default, completionHandler)
    }
}
