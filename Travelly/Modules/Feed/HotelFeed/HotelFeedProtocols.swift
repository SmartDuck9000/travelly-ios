//
//  HotelFeedProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol HotelFeedPresenterProtocol {
    func loadFeed()
    func reloadFeed()
    func hotelsCount() -> Int
    func configureHotelCell(_ cell: HotelTableViewCell, at index: Int)
    func selectHotel(at index: Int)
    
    func goBack()
    func openFilter()
}

protocol HotelFeedInteractorProtocol {
    func loadFeed(complition: @escaping (Error?, Bool, Bool) -> Void)
    func setNeedReload(_ needReload: Bool)
    
    func hotelsCount() -> Int
    func getHotelData(at index: Int) -> HotelData
    
    func getTokens() -> SecurityTokens
    
    func getHotelFilterData() -> HotelFilter
    func setHotelFilterData(_ hotelFilter: HotelFilter)
    
    func deleteAuthData()
}

protocol HotelFeedRouterProtocol {
    func goBack()
    func openFullInfo(with id: Int, _ tokens: SecurityTokens)
    func openFilter(with presenter: HotelFilterPresenterProtocol)
    
    func openAuth()
}

protocol HotelFeedAssemblyProtocol {
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> HotelFeedViewController
}
