//
//  UserSettingsResponse.swift
//  Auction
//
//  Created by Q on 11/12/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class UserSettingsResponse: NSObject {

    let language: String?
    let currency: String?
    
    struct BaseKeys
    {
        static let language = "language"
        static let currency = "currency"
    }
    
    init(dictionary: [String : Any])
    {
        language = dictionary[BaseKeys.language] as? String
        currency = dictionary[BaseKeys.currency] as? String
    }
}
