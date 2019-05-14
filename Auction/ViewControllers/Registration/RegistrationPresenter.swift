//
//  RegistrationPresenter.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class RegistrationPresenter: RegistrationPresenterProtocol, RegistrationInteractorOutputProtocol {

    weak private var view: RegistrationViewProtocol?
    var interactor: RegistrationInteractorInputProtocol?
    private let router: RegistrationWireframeProtocol

    init(interface: RegistrationViewProtocol, interactor: RegistrationInteractorInputProtocol?, router: RegistrationWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func receiveMessage(message: [String: Any]) {
        self.view?.messageReceived(message: message)
    }

    func messageError() {
        self.view?.showMessageError()
    }
}
