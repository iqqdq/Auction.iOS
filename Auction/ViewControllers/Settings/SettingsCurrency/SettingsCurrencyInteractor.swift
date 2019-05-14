//
//  SettingsCurrencyInteractor.swift
//  Auction
//
//  Created by Q on 25/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

class SettingsCurrencyInteractor: SettingsCurrencyInteractorInputProtocol {

    weak var presenter: SettingsCurrencyInteractorOutputProtocol?

    func getCurrency() {
        let webService = AuctionWebService.init()
        webService.GETQuery(endpoint: URLs.settings_currency, success: { (response) in
            
            if let responseDict = response as? [String : Any] {
                self.presenter?.receiveCurrency(currencyDictionary: responseDict)
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
    
    
    func setUserCurrency(currencyDictionary: [String: Any]) {
        let webService = AuctionWebService.init()
        webService.PUTQuery(endpoint: URLs.user_settings, params: currencyDictionary as [String : Any], success: { (response) in
            
            if let responseDict = response as? [String : Any] {
                print(responseDict)
                self.presenter?.currencySetted()
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
}
