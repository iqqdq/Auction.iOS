//
//  ProfileResponse.swift
//  Auction
//
//  Created by Q on 30/03/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import Foundation

struct ProfileResponse: Codable {
    let firstName, lastName, username, phoneNumber: String?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case phoneNumber = "phone_number"
        case email
    }
}
