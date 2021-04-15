//
//  HotelFeedProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol HotelFeedPresenterProtocol {
    func loadFeed()
    func hotelsCount() -> Int
    func configureHotelCell(_ cell: HotelCollectionViewCell, at index: Int)
    func selectHotel(at index: Int)
}

protocol HotelFeedInteractorProtocol {
    func loadFeed(complition: @escaping (Error?, Bool) -> Void)
    
    func hotelsCount() -> Int
    func getHotelData(at index: Int) -> HotelData
    
    func getTokens() -> SecurityTokens
    
    func deleteAuthData()
}

protocol HotelFeedRouterProtocol {
    func goBack()
    func openFullInfo(with id: Int, _ tokens: SecurityTokens)
    
    func openAuth()
}

protocol HotelFeedAssemblyProtocol {
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> HotelFeedViewController
}
