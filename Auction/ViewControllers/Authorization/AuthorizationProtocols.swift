//
//  AuthorizationProtocols.swift
//  Auction
//
//  Created by Q on 29/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol AuthorizationWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol AuthorizationPresenterProtocol: class {

    var interactor: AuthorizationInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol AuthorizationInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    func receiveToken(token: [String: Any])
    func authError()
    func authSuccess(token: [String: Any])
}

protocol AuthorizationInteractorInputProtocol: class {

    var presenter: AuthorizationInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
    func getToken(accountDictionary: [String: Any])
}

// MARK: ViewProtocol

protocol AuthorizationViewProtocol: class {

    var presenter: AuthorizationPresenterProtocol? { get set }

    /** Presenter -> ViewController */
    func hasLoggedIn(token: [String: Any])
    func showAuthError()
}
