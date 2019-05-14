//
//  SettingsLanguagePresenter.swift
//  Auction
//
//  Created by Q on 25/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import UIKit

class SettingsLanguagePresenter: SettingsLanguagePresenterProtocol, SettingsLanguageInteractorOutputProtocol {

    weak private var view: SettingsLanguageViewProtocol?
    var interactor: SettingsLanguageInteractorInputProtocol?
    private let router: SettingsLanguageWireframeProtocol

    init(interface: SettingsLanguageViewProtocol, interactor: SettingsLanguageInteractorInputProtocol?, router: SettingsLanguageWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func receiveLanguage(languageDictionary: [String : Any]) {
        self.view?.setLanguage(language: languageDictionary)
    }
    
    func languageSetted() {
        self.view?.languageSelected()
    }
}
