//
//  ClosedLotResponse.swift
//  Auction
//
//  Created by Q on 15/12/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

typealias ClosedLot = [ClosedLotResponse]

class ClosedLotResponse: Codable {
    let id: Int?
    let lotName: String?
    let lotDescriptions: String?
    let startPrice: String?
    let startTime: String?
    let closedTime: Date?
    let mainImage: String?
    let status: Int?
    
    struct BaseKeys {
        static let id = "id"
        static let lotName = "lot_name"
        static let lotDescriptions = "lotDescriptions"
        static let startPrice = "start_price"
        static let startTime = "start_time"
        static let closedTime = "closed_time"
        static let mainImage = "main_image"
        static let status = "status"
    }
    
    init(dictionary: [String: Any]) {
        id = dictionary[BaseKeys.id] as? Int
        lotName = dictionary[BaseKeys.lotName] as? String
        lotDescriptions = dictionary[BaseKeys.lotDescriptions] as? String
        startPrice = dictionary[BaseKeys.startPrice] as? String
        startTime = dictionary[BaseKeys.startTime] as? String
        closedTime = dictionary[BaseKeys.closedTime] as? Date
        mainImage = dictionary[BaseKeys.mainImage] as? String
        status = dictionary[BaseKeys.status] as? Int
    }
}
