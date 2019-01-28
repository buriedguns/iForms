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
    
    func requestServer(_ metaDataBaseURL: Bool, _ method: HTTPMethod, _ path: String, params: [String: Any]?, queryItems: [NSURLQueryItem]?, _ encoding: ParameterEncoding,_ completionHandler: @escaping(JSON) -> Void) {
        
        var url: URL?
        
        if metaDataBaseURL == true {
            url = dataBaseURL!.appendingPathComponent(path)
        }else{
            url = authBaseURL!.appendingPathComponent(path)
        }
        
        var header = self.headers
        header = ["Authorization": self.accessToken,
                  "Accept": "application/json"]
        
        
        let urlComps = NSURLComponents(url: url!, resolvingAgainstBaseURL: false)!
        urlComps.queryItems = queryItems as [URLQueryItem]?
        url = urlComps.url!
        
        Alamofire.request(url!, method: method, parameters: params, encoding: encoding, headers: header).responseJSON{ response in
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
    
    func getAllUsers(completionHandler: @escaping(JSON) -> Void) {
        let path = "/rest/users"
        requestServer(false, .get, path, params: nil, queryItems: [NSURLQueryItem(name: "offset", value: "0"), NSURLQueryItem(name: "limit", value: "500")],  JSONEncoding.default, completionHandler)
    }
    
    func createUser(_ params: [String: Any]?, completionHandler: @escaping(JSON) -> Void) {
        let path = "rest/users"
        requestServer(false, .post, path, params: params, queryItems: nil, JSONEncoding.default, completionHandler)
    }
    
    func editUser(_ userName: String,_ params: [String: Any]?, completionHandler: @escaping(JSON) -> Void) {
        let path = "rest/users/\(userName)"
        requestServer(false, .put, path, params: params, queryItems: nil, JSONEncoding.default, completionHandler)
    }
    
    func getAllGroups(completionHandler: @escaping(JSON) -> Void) {
        let path = "/rest/groups"
        requestServer(false, .get, path, params: nil, queryItems: [NSURLQueryItem(name: "offset", value: "0"), NSURLQueryItem(name: "limit", value: "500")],  JSONEncoding.default, completionHandler)
    }
    
    func createGroup(_ params: [String: Any]?, completionHandler: @escaping(JSON) -> Void) {
        let path = "rest/groups"
        requestServer(false, .post, path, params: params, queryItems: nil, JSONEncoding.default, completionHandler)
    }
    
    func editGroup(_ groupName: String,_ params: [String: Any]?, completionHandler: @escaping(JSON) -> Void) {
        let path = "rest/groups/\(groupName)"
        requestServer(false, .put, path, params: params, queryItems: nil, JSONEncoding.default, completionHandler)
    }
    
    func getAllAttributes(completionHandler: @escaping(JSON) -> Void) {
    let path = "/attribute-types/list"
    requestServer(true, .get, path, params: nil, queryItems: [NSURLQueryItem(name: "offset", value: "0"), NSURLQueryItem(name: "limit", value: "500")],  JSONEncoding.default, completionHandler)
    }
}
