//
//  TokenResponse.swift
//  Auction
//
//  Created by Q on 26/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class TokenResponse: NSObject {
    
    let token: String?
    
    struct BaseKeys
    {
        static let token = "token"
    }
    
    init(dictionary: [String : Any])
    {
        token = dictionary[BaseKeys.token] as? String
    }
}
