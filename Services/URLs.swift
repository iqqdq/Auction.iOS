//
//  URLs.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

struct URLs {

    static let baseUrl = "http://vente.pp.ua:8000/"
    
    static let wsUrl = "ws://vente.pp.ua/ws/bet/"
    
    static let registration = baseUrl + "user/phone_verification/"
    
    static let token_validation = baseUrl + "user/token_validation/"
    
    static let authorization = baseUrl + "user/auth/"

    static let newLots = baseUrl + "api/lot/new/"
    
    static let startedLots = baseUrl + "api/lot/started/"
    
    static let closedLots = baseUrl + "api/lot/closed/"
    
    static let user_profile = baseUrl + "user/profile/"
    
    static let user_logout = baseUrl + "user/logout/"
    
    static let user_settings = baseUrl + "api/settings/user_settings/"
    
    static let settings_currency = baseUrl + "api/settings/currency/"
    
    static let settings_language = baseUrl + "api/settings/language/"
}
