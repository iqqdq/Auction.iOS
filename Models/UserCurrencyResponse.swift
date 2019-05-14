//
//  UserCurrencyResponse.swift
//  Auction
//
//  Created by Q on 10/12/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class UserCurrencyResponse: Codable {
    let data: [Currency]?
    
    init(data: [Currency]?) {
        self.data = data
    }
}

class Currency: Codable {
    let currency: String?
    
    init(currency: String?) {
        self.currency = currency
    }
}
