//
//  SettingsCurrencyProtocols.swift
//  Auction
//
//  Created by Q on 25/10/2018.
//  Copyright © 2018 Oxbee. All rights reserved.
//

import Foundation

// MARK: WireFrameProtocol

protocol SettingsCurrencyWireframeProtocol: class {

}

// MARK: PresenterProtocol

protocol SettingsCurrencyPresenterProtocol: class {

    var interactor: SettingsCurrencyInteractorInputProtocol? { get set }
}

// MARK: InteractorProtocol

protocol SettingsCurrencyInteractorOutputProtocol: class {

    /** Interactor -> Presenter */
    func receiveCurrency(currencyDictionary: [String : Any])
    func currencySetted()
}

protocol SettingsCurrencyInteractorInputProtocol: class {

    var presenter: SettingsCurrencyInteractorOutputProtocol? { get set }

    /** Presenter -> Interactor */
    func getCurrency()
    func setUserCurrency(currencyDictionary: [String: Any])
}

// MARK: ViewProtocol

protocol SettingsCurrencyViewProtocol: class {

    var presenter: SettingsCurrencyPresenterProtocol? { get set }

    /** Presenter -> ViewController */
    func setCurrency(currency: [String : Any])
    func currencySelected()
}
