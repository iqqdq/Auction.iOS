//
//  NewAuctionsProtocols.swift
//  Auction
//
//  Created by Q on 21/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol NewAuctionsWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol NewAuctionsPresenterProtocol: class {

    var interactor: NewAuctionsInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol NewAuctionsInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    func receiveNewLots(newLotsArray: NSArray)
    func receiveStartedLots(startedLotsArray: NSArray)
    func selectStartedLot(startedLotDictionary:[String : Any])
    func emptyNewLots()
}

protocol NewAuctionsInteractorInputProtocol: class {

    var presenter: NewAuctionsInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
    func getNewLots()
    func getStartedLots()
    func getStartedLot(lotId: String)
}

// MARK: ViewProtocol

protocol NewAuctionsViewProtocol: class {

    var presenter: NewAuctionsPresenterProtocol? { get set }

    /** Presenter -> ViewController */
    func updateNewLots(newLots: NSArray)
    func updateStartedLots(startedLots: NSArray)
    func startedLotSelected(startedLot: [String : Any])
    func showEmptyLotsError()
}
