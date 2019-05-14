//
//  UserRegisterResponse.swift
//  Auction
//
//  Created by Q on 25/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserRegisterResponse: NSObject {

    let id: Int?
    let username: String?
    let status: String?
    
    struct BaseKeys
    {
        static let id = "id"
        static let username = "username"
        static let status = "status"
    }
    
    init(dictionary: [String : Any])
    {
        id = dictionary[BaseKeys.id] as? Int
        username = dictionary[BaseKeys.username] as? String
        status = dictionary[BaseKeys.status] as? String
    }
}
