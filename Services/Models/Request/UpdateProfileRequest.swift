//
//  UpdateProfileRequest.swift
//  Auction
//
//  Created by Q on 30/03/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import UIKit

struct UpdateProfileRequest: Codable {
    let firstName, lastName, username, email: String?
    let phoneNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case username, email
        case phoneNumber = "phone_number"
    }
}
