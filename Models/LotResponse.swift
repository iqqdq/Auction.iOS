//
//  NewLotsResponse.swift
//  Auction
//
//  Created by Q on 07/12/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

typealias Lot = [LotResponse]

class LotResponse: Codable {
    let id: Int?
    let lotName: String?
    let startPrice: String?
    let startTime: Date?
    let mainImage: String?
    let status: Int?
    
    struct BaseKeys {
        static let id = "id"
        static let lotName = "lot_name"
        static let startPrice = "start_price"
        static let startTime = "start_time"
        static let mainImage = "main_image"
        static let status = "status"
    }
    
    init(dictionary: [String: Any]) {
        id = dictionary[BaseKeys.id] as? Int
        lotName = dictionary[BaseKeys.lotName] as? String
        startPrice = dictionary[BaseKeys.startPrice] as? String
        startTime = dictionary[BaseKeys.startTime] as? Date
        mainImage = dictionary[BaseKeys.mainImage] as? String
        status = dictionary[BaseKeys.status] as? Int
    }
}

