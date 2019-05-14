//
//  ConfirmCodeProtocols.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol ConfirmCodeWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol ConfirmCodePresenterProtocol: class {

    var interactor: ConfirmCodeInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol ConfirmCodeInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    func receiveUserID(userID: [String: Any])
    func registerFailed()
    func authSuccess(token: [String: Any])
}

protocol ConfirmCodeInteractorInputProtocol: class {

    var presenter: ConfirmCodeInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
    func validateAccount(userDictionary: [String: Any])
    func getToken(accountDictionary: [String: Any])
}

// MARK: ViewProtocol

protocol ConfirmCodeViewProtocol: class {

    var presenter: ConfirmCodePresenterProtocol? { get set }

    /** Presenter -> ViewController */
    func userIdReceived(userID: [String: Any])
    func showRegisterError()
    func hasLoggedIn(tokenDict: [String: Any])
}
