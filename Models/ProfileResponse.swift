//
//  ProfileResponse.swift
//  Auction
//
//  Created by Q on 08/12/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class ProfileResponse: NSObject {

    let id: Int?
    let nickname: String?
    let phone_number: String?
    let address: String?
    
    struct BaseKeys
    {
        static let id = "id"
        static let nickname = "nickname"
        static let phone_number = "phone_number"
        static let address = "address"
    }
    
    init(dictionary: [String : Any])
    {
        id = dictionary[BaseKeys.id] as? Int
        nickname = dictionary[BaseKeys.nickname] as? String
        phone_number = dictionary[BaseKeys.phone_number] as? String
        address = dictionary[BaseKeys.address] as? String
    }
}
