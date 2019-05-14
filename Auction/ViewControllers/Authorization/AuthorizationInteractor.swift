//
//  AuthorizationInteractor.swift
//  Auction
//
//  Created by Q on 29/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

class AuthorizationInteractor: AuthorizationInteractorInputProtocol {

    weak var presenter: AuthorizationInteractorOutputProtocol?

    func getToken(accountDictionary: [String: Any]) {
        let webService = AuctionWebService.init()
        webService.POSTQuery(endpoint: URLs.authorization, params: accountDictionary as [String : Any], success: { (response) in
            let token: Dictionary<String, AnyObject> = response as! Dictionary
            
            if let responseDict = response as? [String : Any] {
                let tokenModel = TokenResponse.init(dictionary: responseDict)
                if (tokenModel.token != nil) {
                    self.presenter?.authSuccess(token: token)
                    print(token)
                } else {
                    self.presenter?.authError()
                }
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
}
