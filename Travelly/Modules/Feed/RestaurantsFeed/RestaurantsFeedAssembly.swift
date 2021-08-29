//
//  RestaurantsFeedAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class RestaurantsFeedAssembly: RestaurantsFeedAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: RestaurantsFeedRouterProtocol.self, name: "RestaurantsFeedRouter") { (vc) -> RestaurantsFeedRouterProtocol in
            return RestaurantsFeedRouter(view: vc)
        }
        
        AppDelegate.container.register(service: RestaurantsFeedInteractorProtocol.self, name: "RestaurantsFeedInteractor") { (networkService, dataStorage, userId, tokens) -> RestaurantsFeedInteractorProtocol in
            return RestaurantsFeedInteractor(networkService: networkService, dataStorage: dataStorage, userId: userId, tokens: tokens)
        }
        
        AppDelegate.container.register(service: RestaurantsFeedPresenterProtocol.self, name: "RestaurantsFeedPresenter") { (vc, router, interactor) -> RestaurantsFeedPresenterProtocol in
            return RestaurantsFeedPresenter(view: vc, router: router, interactor: interactor)
        }
        
        AppDelegate.container.register(service: RestaurantsFeedViewController.self, name: "RestaurantsFeedViewController") { (userId: Int, tokens: SecurityTokens) -> RestaurantsFeedViewController in
            let vc = RestaurantsFeedViewController()
            
            guard let router = AppDelegate.container.resolve(service: RestaurantsFeedRouterProtocol.self, name: "RestaurantsFeedRouter", argument: vc)
            else {
                return RestaurantsFeedViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return RestaurantsFeedViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return RestaurantsFeedViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: RestaurantsFeedInteractorProtocol.self, name: "RestaurantsFeedInteractor", arguments: networkService, dataStorage, userId, tokens)
            else {
                return RestaurantsFeedViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: RestaurantsFeedPresenterProtocol.self, name: "RestaurantsFeedPresenter", arguments: vc, router, interactor)
            else {
                return RestaurantsFeedViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> RestaurantsFeedViewController {
        return AppDelegate.container.resolve(service: RestaurantsFeedViewController.self,
                                             name: "RestaurantsFeedViewController",
                                             arguments: userId, tokens) ?? RestaurantsFeedViewController()
    }
}
