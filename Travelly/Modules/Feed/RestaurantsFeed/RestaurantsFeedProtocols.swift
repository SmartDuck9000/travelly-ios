//
//  RestaurantsFeedProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol RestaurantsFeedPresenterProtocol {
    func loadFeed()
    func reloadFeed()
    func restaurantsCount() -> Int
    func configureRestaurantsCell(_ cell: RestaurantsTableViewCell, at index: Int)
    func selectRestaurant(at index: Int)
    
    func goBack()
    func openFilter()
}

protocol RestaurantsFeedInteractorProtocol {
    func loadFeed(complition: @escaping (Error?, Bool, Bool) -> Void)
    func setNeedReload(_ needReload: Bool)
    
    func restaurantsCount() -> Int
    func getRestaurantsData(at index: Int) -> RestaurantsData
    
    func getTokens() -> SecurityTokens
    
    func getRestaurantsFilterData() -> RestaurantsFilter
    func setRestaurantsFilterData(_ restaurantsFilter: RestaurantsFilter)
    
    func deleteAuthData()
}

protocol RestaurantsFeedRouterProtocol {
    func goBack()
    func openFullInfo(with id: Int, _ tokens: SecurityTokens)
    func openFilter(with presenter: RestaurantsFilterPresenterProtocol)
    
    func openAuth()
}

protocol RestaurantsFeedAssemblyProtocol {
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> RestaurantsFeedViewController
}
