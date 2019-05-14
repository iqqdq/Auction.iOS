//
//  ClosedAuctionsProtocols.swift
//  Auction
//
//  Created by Q on 21/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol ClosedAuctionsWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol ClosedAuctionsPresenterProtocol: class {

    var interactor: ClosedAuctionsInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol ClosedAuctionsInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    func receiveClosedLots(closedLotsArray: NSArray)
    func emptyClosedLots()
}

protocol ClosedAuctionsInteractorInputProtocol: class {

    var presenter: ClosedAuctionsInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
    func getClosedLots()
}

// MARK: ViewProtocol

protocol ClosedAuctionsViewProtocol: class {

    var presenter: ClosedAuctionsPresenterProtocol? { get set }

    /** Presenter -> ViewController */
    func updateClosedTokens(closedLots: NSArray)
    func showEmptyLotsError()
}
