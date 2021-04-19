//
//  HotelFeedAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class HotelFeedAssembly: HotelFeedAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: HotelFeedRouterProtocol.self, name: "HotelFeedRouter") { (vc) -> HotelFeedRouterProtocol in
            return HotelFeedRouter(view: vc)
        }
        
        AppDelegate.container.register(service: HotelFeedInteractorProtocol.self, name: "HotelFeedInteractor") { (networkService, dataStorage, userId, tokens) -> HotelFeedInteractorProtocol in
            return HotelFeedInteractor(networkService: networkService, dataStorage: dataStorage, userId: userId, tokens: tokens)
        }
        
        AppDelegate.container.register(service: HotelFeedPresenterProtocol.self, name: "HotelFeedPresenter") { (vc, router, interactor) -> HotelFeedPresenterProtocol in
            return HotelFeedPresenter(view: vc, router: router, interactor: interactor)
        }
        
        AppDelegate.container.register(service: HotelFeedViewController.self, name: "HotelFeedViewController") { (userId: Int, tokens: SecurityTokens) -> HotelFeedViewController in
            let vc = HotelFeedViewController()
            
            guard let router = AppDelegate.container.resolve(service: HotelFeedRouterProtocol.self, name: "HotelFeedRouter", argument: vc)
            else {
                return HotelFeedViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return HotelFeedViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return HotelFeedViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: HotelFeedInteractorProtocol.self, name: "HotelFeedInteractor", arguments: networkService, dataStorage, userId, tokens)
            else {
                return HotelFeedViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: HotelFeedPresenterProtocol.self, name: "HotelFeedPresenter",
                                                                arguments: vc, router, interactor)
            else {
                return HotelFeedViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> HotelFeedViewController {
        return AppDelegate.container.resolve(service: HotelFeedViewController.self,
                                             name: "HotelFeedViewController",
                                             arguments: userId, tokens) ?? HotelFeedViewController()
    }
}
