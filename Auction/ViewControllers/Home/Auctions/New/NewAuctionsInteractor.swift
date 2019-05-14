//
//  NewAuctionsInteractor.swift
//  Auction
//
//  Created by Q on 21/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

class NewAuctionsInteractor: NewAuctionsInteractorInputProtocol {

    weak var presenter: NewAuctionsInteractorOutputProtocol?

    func getNewLots() {
        let webService = AuctionWebService.init()
        webService.GETQuery(endpoint: URLs.newLots, success: { (response) in
            
            if let responseArray = response as? NSArray {
                self.presenter?.receiveNewLots(newLotsArray: responseArray)
                print("new_lot_response : \(responseArray)")
            }
        })
        { (error) in
            print(error ?? "error")
        }
    }
    
    func getStartedLots() {
        let webService = AuctionWebService.init()
        webService.GETQuery(endpoint: URLs.startedLots, success: { (response) in
            
            if let responseArray = response as? NSArray {
                self.presenter?.receiveStartedLots(startedLotsArray: responseArray)
                print("started_lots_response : \(responseArray)")
            }
        } ) { (error) in
            print(error ?? "error")
        }
    }
    
    func getStartedLot(lotId: String) {
        let webService = AuctionWebService.init()
        webService.GETQuery(endpoint: URLs.startedLots + lotId, success: { (response) in
            
            if let responseDictionary = response as? [String : Any] {
                self.presenter?.selectStartedLot(startedLotDictionary: responseDictionary)
                print("started_response : \(responseDictionary)")
            }
        } ) { (error) in
            print(error ?? "error")
        }
    }
}
