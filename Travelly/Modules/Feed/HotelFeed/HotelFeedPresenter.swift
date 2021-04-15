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
    
    func loadFeed() {
        interactor.loadFeed { (error, needAuth) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if needAuth {
                self.interactor.deleteAuthData()
                self.router.openAuth()
            }
        }
    }
    
    func hotelsCount() -> Int {
        return interactor.hotelsCount() + 1
    }
    
    func configureHotelCell(_ cell: HotelCollectionViewCell, at index: Int) {
        if index == interactor.hotelsCount() + 1 {
            interactor.loadFeed { (error, needAuth) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                
                if needAuth {
                    self.interactor.deleteAuthData()
                    self.router.openAuth()
                }
            }
        }
        
        
    }
    
    func selectHotel(at index: Int) {
        let hotelData = interactor.getHotelData(at: index)
        router.openFullInfo(with: hotelData.hotelId, interactor.getTokens())
    }
}
