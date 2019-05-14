//
//  NewAuctionsPresenter.swift
//  Auction
//
//  Created by Q on 21/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class NewAuctionsPresenter: NewAuctionsPresenterProtocol, NewAuctionsInteractorOutputProtocol {

    weak private var view: NewAuctionsViewProtocol?
    var interactor: NewAuctionsInteractorInputProtocol?
    private let router: NewAuctionsWireframeProtocol

    init(interface: NewAuctionsViewProtocol, interactor: NewAuctionsInteractorInputProtocol?, router: NewAuctionsWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func receiveNewLots(newLotsArray: NSArray) {
        self.view?.updateNewLots(newLots: newLotsArray)
    }
    
    func receiveStartedLots(startedLotsArray: NSArray) {
        self.view?.updateStartedLots(startedLots: startedLotsArray)
    }
    
    func selectStartedLot(startedLotDictionary: [String : Any]) {
        self.view?.startedLotSelected(startedLot: startedLotDictionary)
    }
    
    func emptyNewLots() {
        self.view?.showEmptyLotsError()
    }
}
