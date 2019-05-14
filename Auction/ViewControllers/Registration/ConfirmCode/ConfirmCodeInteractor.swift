//
//  ConfirmCodeInteractor.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

class ConfirmCodeInteractor: ConfirmCodeInteractorInputProtocol {

    weak var presenter: ConfirmCodeInteractorOutputProtocol?

    func validateAccount(userDictionary: [String: Any]) {
        let webService = AuctionWebService.init()
        webService.POSTQuery(endpoint: URLs.token_validation, params: userDictionary as [String : Any], success: { (response) in
            let userID: Dictionary<String, AnyObject> = response as! Dictionary
            print(userID)

            if let responseDict = response as? [String : Any] {
                let userRegisterResponse = UserRegisterResponse.init(dictionary: responseDict)
                if (userRegisterResponse.status == "true") {
                    self.presenter?.receiveUserID(userID: userID)
                } else {
                    self.presenter?.registerFailed()
                }
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
    
    func getToken(accountDictionary: [String: Any]) {
        let webService = AuctionWebService.init()
        webService.POSTQuery(endpoint: URLs.authorization, params: accountDictionary as [String : Any], success: { (response) in
            let token: Dictionary<String, AnyObject> = response as! Dictionary
  
            if let responseDict = response as? [String : Any] {
                let tokenModel = TokenResponse.init(dictionary: responseDict)
                if (tokenModel.token != nil) {
                    self.presenter?.authSuccess(token: token)
                } else {
                    print("ERROR TOKEN")
                }
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
}
