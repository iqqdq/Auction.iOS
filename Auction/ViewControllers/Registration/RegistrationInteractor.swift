//
//  RegistrationInteractor.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

class RegistrationInteractor: RegistrationInteractorInputProtocol {

    weak var presenter: RegistrationInteractorOutputProtocol?

    func registerAccount(phoneDictionary: [String: Any]) {
        let webService = AuctionWebService.init()
        webService.POSTQuery(endpoint: URLs.registration, params: phoneDictionary as [String : Any], success: { (response) in
            
            let messageDict: Dictionary<String, AnyObject> = response as! Dictionary
            print(messageDict)
            
            if let responseDict = response as? [String : Any] {
                let authResponseModel = AuthResponse.init(dictionary: responseDict)
                if (authResponseModel.status == true) {
                    self.presenter?.receiveMessage(message: messageDict)
                    print(messageDict)
                } else {
                    self.presenter?.messageError()
                    print(messageDict)
                }
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
}
