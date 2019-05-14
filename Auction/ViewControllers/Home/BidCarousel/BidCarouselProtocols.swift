//
//  BidCarouselProtocols.swift
//  Auction
//
//  Created by Q on 11/01/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol BidCarouselWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol BidCarouselPresenterProtocol: class {

    var interactor: BidCarouselInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol BidCarouselInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
}

protocol BidCarouselInteractorInputProtocol: class {

    var presenter: BidCarouselInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
}

// MARK: ViewProtocol

protocol BidCarouselViewProtocol: class {

    var presenter: BidCarouselPresenterProtocol? { get set }

    /** Presenter -> ViewController */
}
