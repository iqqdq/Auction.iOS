//
//  SettingsPresenter.swift
//  Auction
//
//  Created by Q on 24/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class SettingsPresenter: SettingsPresenterProtocol, SettingsInteractorOutputProtocol {

    weak private var view: SettingsViewProtocol?
    var interactor: SettingsInteractorInputProtocol?
    private let router: SettingsWireframeProtocol

    init(interface: SettingsViewProtocol, interactor: SettingsInteractorInputProtocol?, router: SettingsWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func receiveUserSettings(settingsDictionary: [String : Any]) {
        self.view?.setUserSettings(userSettings: settingsDictionary)
    }
    
    func tokenRemoved() {
        self.view?.hasLogout()
    }
}
