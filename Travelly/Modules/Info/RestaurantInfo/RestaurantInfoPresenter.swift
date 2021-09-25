//
//  RestaurantInfoPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class RestaurantInfoPresenter: RestaurantInfoPresenterProtocol {
    
    private weak var view: RestaurantInfoViewController!
    private let interactor: RestaurantInfoInteractorProtocol
    private let router: RestaurantInfoRouterProtocol
    
    init(view: RestaurantInfoViewController, interactor: RestaurantInfoInteractorProtocol, router: RestaurantInfoRouterProtocol) {
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
            
            guard let restaurantInfo = data else { return }
            
            self.view.setRestaurantName(restaurantInfo.restaurantName)
            self.view.setRestaurantDescription(restaurantInfo.restaurantDescription)
            self.view.setRestaurantAddress(restaurantInfo.restaurantAddr)
            self.view.setRating(restaurantInfo.rating)
            self.view.setAveragePrice(restaurantInfo.averagePrice)
            self.view.setChildMenu(restaurantInfo.childMenu)
            self.view.setSmokingRoom(restaurantInfo.smokingRoom)
            self.view.setCountryName(restaurantInfo.countryName)
            self.view.setCityName(restaurantInfo.cityName)
        }
    }
}
