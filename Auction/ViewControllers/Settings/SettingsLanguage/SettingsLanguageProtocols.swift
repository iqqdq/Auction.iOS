//
//  SettingsLanguageProtocols.swift
//  Auction
//
//  Created by Q on 25/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol SettingsLanguageWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol SettingsLanguagePresenterProtocol: class {

    var interactor: SettingsLanguageInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol SettingsLanguageInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    func receiveLanguage(languageDictionary: [String : Any])
    func languageSetted()
}

protocol SettingsLanguageInteractorInputProtocol: class {

    var presenter: SettingsLanguageInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
    func getLanguage()
    func setUserLanguage(languageDictionary: [String: Any])
}

// MARK: ViewProtocol

protocol SettingsLanguageViewProtocol: class {

    var presenter: SettingsLanguagePresenterProtocol? { get set }

    /** Presenter -> ViewController */
    func setLanguage(language: [String : Any])
    func languageSelected()
}
