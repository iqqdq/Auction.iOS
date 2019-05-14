//
//  LotsResponse.swift
//  Auction
//
//  Created by Q on 29/03/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import Foundation

struct LotsResponse: Codable {
    let data: [LotData]?
}

struct LotData: Codable {
    let id: Int?
    let name: String?
    let betsCount, status: Int?
    let mainImage, currentPrice, statusText: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case betsCount = "bets_count"
        case status
        case mainImage = "main_image"
        case currentPrice = "current_price"
        case statusText = "status_text"
    }
}

