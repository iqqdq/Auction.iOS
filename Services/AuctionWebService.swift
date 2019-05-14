//
//  AuctionWebService.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuctionWebService: NSObject {
    
    func POSTQuery(endpoint: String, params: [String: Any]? = nil, success:@escaping (_ responseObject: Any?) -> Void ,failure: @escaping (_ error: String?) -> Void ) {
     
        Alamofire.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    if let data = response.data {
                        print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    print(error)
                    
                case .success(let responseData):
                    success(responseData)
                }
        }
    }
        
    
    func GETQuery(endpoint: String, params: [String: Any]? = nil, success:@escaping (_ responseObject: Any?) -> Void ,failure: @escaping (_ error:
        String?) -> Void ) {
        
        var headers: HTTPHeaders = [:]
        
        if (UserDefaults.standard.object(forKey: "token") != nil) {
            headers = ["Authorization" : "token \(UserDefaults.standard.object(forKey: "token")!)",
                "Content-Type" : "application/x-www-form-urlencoded"]
        }
        
        Alamofire.request(endpoint, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<600)
            .responseJSON { response in

                switch response.result
                {
                case .failure(let error):
                    if let data = response.data {
                        print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    print(error)
                    
                case .success(let responseData):
                    success(responseData)
 
                }
        }
    }
    
    func GETLogoutQuery(endpoint: String, params: [String: Any]? = nil, success:@escaping (_ responseObject: Any?) -> Void ,failure: @escaping (_ error:
        String?) -> Void ) {
        
        var headers: HTTPHeaders = [:]
        
        if (UserDefaults.standard.object(forKey: "token") != nil) {
            headers = ["Authorization" : "token \(UserDefaults.standard.object(forKey: "token")!)",
                "Content-Type" : "application/x-www-form-urlencoded"]
        }
    
        Alamofire.request(endpoint, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<600)
            .responseString { response in
                
                switch response.result
                {
                case .failure(let error):
                    if let data = response.data {
                        print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    print(error)
                    
                case .success(let responseData):
                    success(responseData)
                    
                }
        }
    }
    
    func PUTQuery(endpoint: String, params: [String: Any]? = nil, success:@escaping (_ responseObject: Any?) -> Void ,failure: @escaping (_ error:
        String?) -> Void ) {
        
        let headers: HTTPHeaders = ["Authorization" : "token \(UserDefaults.standard.object(forKey: "token")!)",
            "Content-Type" : "application/x-www-form-urlencoded"]
        
        Alamofire.request(endpoint, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    if let data = response.data {
                        print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    print(error)
                    
                case .success(let responseData):
                    success(responseData)                    
                }
        }
    }
    
    func PUTProfileQuery(endpoint: String, params: [String: Any]? = nil, success:@escaping (_ responseObject: Any?) -> Void ,failure: @escaping (_ error:
        String?) -> Void ) {
        
        let headers: HTTPHeaders = ["Authorization" : "token \(UserDefaults.standard.object(forKey: "token")!)",
            "Content-Type" : "application/x-www-form-urlencoded"]
        
        Alamofire.request(endpoint, method: .put, parameters: params, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    if let data = response.data {
                        print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                    }
                    print(error)
                    
                case .success(let responseData):
                    success(responseData)
                }
        }
    }
}
