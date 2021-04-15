//
//  HotelFeedPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class HotelFeedPresenter: HotelFeedPresenterProtocol {

    private weak var view: HotelFeedViewController!
    private let router: HotelFeedRouterProtocol
    private let interactor: HotelFeedInteractorProtocol
    
    init(view: HotelFeedViewController, router: HotelFeedRouterProtocol, interactor: HotelFeedInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}
