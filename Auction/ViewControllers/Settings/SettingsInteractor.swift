//
//  SettingsInteractor.swift
//  Auction
//
//  Created by Q on 24/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorInputProtocol {

    weak var presenter: SettingsInteractorOutputProtocol?

    func getUserSettings() {
        let webService = AuctionWebService.init()
        webService.GETQuery(endpoint: URLs.user_settings, success: { (response) in
            
            if let responseDict = response as? [String : Any] {
                self.presenter?.receiveUserSettings(settingsDictionary: responseDict)
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
    
    func removeToken() {
        let webService = AuctionWebService.init()
        webService.GETLogoutQuery(endpoint: URLs.user_logout, params: nil, success: { (response) in
            
            if response as? String != nil {
                print(response ?? "logout error")
                self.presenter?.tokenRemoved()
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
}
