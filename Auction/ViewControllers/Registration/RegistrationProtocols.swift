//
//  RegistrationProtocols.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol RegistrationWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol RegistrationPresenterProtocol: class {

    var interactor: RegistrationInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol RegistrationInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    func receiveMessage(message: [String: Any])
    func messageError()
}

protocol RegistrationInteractorInputProtocol: class {

    var presenter: RegistrationInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
    func registerAccount(phoneDictionary: [String: Any])
}

// MARK: ViewProtocol

protocol RegistrationViewProtocol: class {

    var presenter: RegistrationPresenterProtocol? { get set }

    /** Presenter -> ViewController */
    func messageReceived(message: [String: Any])
    func showMessageError()
}
