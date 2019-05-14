//
//  UnpaidWinsProtocols.swift
//  Auction
//
//  Created by Q on 12/01/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol UnpaidWinsWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol UnpaidWinsPresenterProtocol: class {

    var interactor: UnpaidWinsInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol UnpaidWinsInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
}

protocol UnpaidWinsInteractorInputProtocol: class {

    var presenter: UnpaidWinsInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
}

// MARK: ViewProtocol

protocol UnpaidWinsViewProtocol: class {

    var presenter: UnpaidWinsPresenterProtocol? { get set }

    /** Presenter -> ViewController */
}
