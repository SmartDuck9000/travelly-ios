//
//  HotelInfoPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class HotelInfoPresenter: HotelInfoPresenterProtocol {
    
    private weak var view: HotelInfoViewController!
    private let interactor: HotelInfoInteractorProtocol
    private let router: HotelInfoRouterProtocol
    
    init(view: HotelInfoViewController, interactor: HotelInfoInteractorProtocol, router: HotelInfoRouterProtocol) {
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
            
            guard let hotelInfo = data else { return }
            
            self.view.setHotelName(hotelInfo.hotelName)
            self.view.setHotelDescription(hotelInfo.hotelDescription)
            self.view.setHotelAddress(hotelInfo.hotelAddr)
            self.view.setStars(hotelInfo.stars)
            self.view.setHotelRating(hotelInfo.hotelRating)
            self.view.setAveragePrice(hotelInfo.averagePrice)
            self.view.setNearSea(hotelInfo.nearSea)
            self.view.setCountryName(hotelInfo.countryName)
            self.view.setCityName(hotelInfo.cityName)
        }
    }
}
