//
//  WalletBalanceProtocols.swift
//  Auction
//
//  Created by Q on 26/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol WalletBalanceWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol WalletBalancePresenterProtocol: class {

    var interactor: WalletBalanceInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol WalletBalanceInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
}

protocol WalletBalanceInteractorInputProtocol: class {

    var presenter: WalletBalanceInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
}

// MARK: ViewProtocol

protocol WalletBalanceViewProtocol: class {

    var presenter: WalletBalancePresenterProtocol? { get set }

    /** Presenter -> ViewController */
}
