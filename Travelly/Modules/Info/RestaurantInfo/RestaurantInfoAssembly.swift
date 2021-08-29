//
//  RestaurantInfoAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class RestaurantInfoAssembly: RestaurantsInfoAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: RestaurantInfoRouterProtocol.self, name: "RestaurantInfoRouter") { (vc) -> RestaurantInfoRouterProtocol in
            return RestaurantInfoRouter(view: vc)
        }
        
        AppDelegate.container.register(service: RestaurantInfoInteractorProtocol.self, name: "RestaurantInfoInteractor") { (networkService, dataStorage, restaurantId, tokens) -> RestaurantInfoInteractor in
            return RestaurantInfoInteractor(networkService: networkService, dataStorage: dataStorage, restaurantId: restaurantId, tokens: tokens)
        }
        
        AppDelegate.container.register(service: RestaurantInfoPresenterProtocol.self, name: "RestaurantInfoPresenter") { (vc, interactor, router) -> RestaurantInfoPresenter in
            return RestaurantInfoPresenter(view: vc, interactor: interactor, router: router)
        }
        
        AppDelegate.container.register(service: RestaurantInfoViewController.self, name: "RestaurantInfoViewController") { (restaurantId: Int, tokens: SecurityTokens) -> RestaurantInfoViewController in
            let vc = RestaurantInfoViewController()
            
            guard let router = AppDelegate.container.resolve(service: RestaurantInfoRouterProtocol.self, name: "RestaurantInfoRouter", argument: vc)
            else {
                return RestaurantInfoViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return RestaurantInfoViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return RestaurantInfoViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: RestaurantInfoInteractorProtocol.self, name: "RestaurantInfoInteractor", arguments: networkService, dataStorage, restaurantId, tokens)
            else {
                return RestaurantInfoViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: RestaurantInfoPresenterProtocol.self, name: "RestaurantInfoPresenter", arguments: vc, interactor, router)
            else {
                return RestaurantInfoViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with restaurantId: Int, _ tokens: SecurityTokens) -> RestaurantInfoViewController {
        return AppDelegate.container.resolve(service: RestaurantInfoViewController.self,
                                             name: "RestaurantInfoViewController",
                                             arguments: restaurantId, tokens) ?? RestaurantInfoViewController()
    }
}
