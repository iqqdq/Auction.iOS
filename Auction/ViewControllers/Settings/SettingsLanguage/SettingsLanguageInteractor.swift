//
//  SettingsLanguageInteractor.swift
//  Auction
//
//  Created by Q on 25/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

class SettingsLanguageInteractor: SettingsLanguageInteractorInputProtocol {

    weak var presenter: SettingsLanguageInteractorOutputProtocol?

    func getLanguage() {
        let webService = AuctionWebService.init()
        webService.GETQuery(endpoint: URLs.settings_language, success: { (response) in
            
            if let responseDict = response as? [String : Any] {
                self.presenter?.receiveLanguage(languageDictionary: responseDict)
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
    
    func setUserLanguage(languageDictionary: [String: Any]) {
        let webService = AuctionWebService.init()
        webService.PUTQuery(endpoint: URLs.user_settings, params: languageDictionary as [String : Any], success: { (response) in
            
            if let responseDict = response as? [String : Any] {
                print("get = \(responseDict)")
                self.presenter?.languageSetted()
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
}
