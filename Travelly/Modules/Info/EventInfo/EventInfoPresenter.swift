//
//  EventInfoPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class EventInfoPresenter: EventInfoPresenterProtocol {
    
    private weak var view: EventInfoViewController!
    private let interactor: EventInfoInteractorProtocol
    private let router: EventInfoRouterProtocol
    
    init(view: EventInfoViewController, interactor: EventInfoInteractorProtocol, router: EventInfoRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func goBack() {
        router.goBack()
    }
    
    func loadInfo() {
        interactor.loadInfo { (error, needAuth, data) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if needAuth {
                self.interactor.deleteAuth()
                self.router.openAuth()
            }
            
            guard let eventInfo = data else { return }
            
            self.view.setEventName(eventInfo.eventName)
            self.view.setEventDescription(eventInfo.eventDescription)
            self.view.setEventAddress(eventInfo.eventAddr)
            self.view.setRating(eventInfo.rating)
            self.view.setAveragePrice(eventInfo.price)
            self.view.setCountryName(eventInfo.countryName)
            self.view.setCityName(eventInfo.cityName)
        }
    }
}
