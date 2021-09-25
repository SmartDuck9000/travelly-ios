//
//  RestaurantInfoProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import Foundation

protocol RestaurantInfoPresenterProtocol {
    func goBack()
    func loadInfo()
}

protocol RestaurantInfoInteractorProtocol {
    func loadInfo(complition: @escaping (Error?, Bool, RestaurantInfo?) -> Void)
    func deleteAuth()
}

protocol RestaurantInfoRouterProtocol {
    func goBack()
    func openAuth()
}

protocol RestaurantsInfoAssemblyProtocol {
    func createModule(with restaurantId: Int, _ tokens: SecurityTokens) -> RestaurantInfoViewController
}
