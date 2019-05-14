//
//  ClosedAuctionsInteractor.swift
//  Auction
//
//  Created by Q on 21/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

class ClosedAuctionsInteractor: ClosedAuctionsInteractorInputProtocol {

    weak var presenter: ClosedAuctionsInteractorOutputProtocol?

    func getClosedLots() {
        let webService = AuctionWebService.init()
        webService.GETQuery(endpoint: URLs.closedLots, success: { (response) in

            if let responseArray = response as? NSArray {
                self.presenter?.receiveClosedLots(closedLotsArray: responseArray)
                print("closed_lot_response : \(responseArray)")
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
}
