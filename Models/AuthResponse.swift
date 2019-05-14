//
//  AuthResponse.swift
//  Auction
//
//  Created by Q on 26/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class AuthResponse: NSObject {
    
    let status: Bool?
    let message: String?
    
    struct BaseKeys
    {
        static let status = "status"
        static let message = "message"
    }
    
    init(dictionary: [String : Any])
    {
        status = dictionary[BaseKeys.status] as? Bool
        message = dictionary[BaseKeys.message] as? String
    }
}
