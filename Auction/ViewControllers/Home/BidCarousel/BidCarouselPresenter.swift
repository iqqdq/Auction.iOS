//
//  BidCarouselPresenter.swift
//  Auction
//
//  Created by Q on 11/01/2019.
//  Copyright © 2019 Oxbee. All rights reserved.
//

import UIKit

class BidCarouselPresenter: BidCarouselPresenterProtocol, BidCarouselInteractorOutputProtocol {

    weak private var view: BidCarouselViewProtocol?
    var interactor: BidCarouselInteractorInputProtocol?
    private let router: BidCarouselWireframeProtocol

    init(interface: BidCarouselViewProtocol, interactor: BidCarouselInteractorInputProtocol?, router: BidCarouselWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
