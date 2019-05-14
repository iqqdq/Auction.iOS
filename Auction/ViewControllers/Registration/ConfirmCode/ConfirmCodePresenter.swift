//
//  ConfirmCodePresenter.swift
//  Auction
//
//  Created by Q on 24/11/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class ConfirmCodePresenter: ConfirmCodePresenterProtocol, ConfirmCodeInteractorOutputProtocol {

    weak private var view: ConfirmCodeViewProtocol?
    var interactor: ConfirmCodeInteractorInputProtocol?
    private let router: ConfirmCodeWireframeProtocol

    init(interface: ConfirmCodeViewProtocol, interactor: ConfirmCodeInteractorInputProtocol?, router: ConfirmCodeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func receiveUserID(userID: [String: Any]) {
        self.view?.userIdReceived(userID: userID)
    }
    
    func registerFailed() {
        self.view?.showRegisterError()
    }
    
    func authSuccess(token: [String: Any]) {
        self.view?.hasLoggedIn(tokenDict:token)
    }
}
