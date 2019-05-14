//
//  StartedLotResponse.swift
//  Auction
//
//  Created by Q on 29/03/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import Foundation

struct StartedLotResponse: Codable {
    let data: StartedLotData?
}

struct StartedLotData: Codable {
    let id: Int?
    let name: String?
    let status: Int?
    let descriptions: String?
    let startDate: String?
    let currentPrice: String?
    let bets: [Bet]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, descriptions
        case startDate = "start_date"
        case currentPrice = "current_price"
        case bets
    }
}

struct Bet: Codable {
    let value, date, username: String?
}

