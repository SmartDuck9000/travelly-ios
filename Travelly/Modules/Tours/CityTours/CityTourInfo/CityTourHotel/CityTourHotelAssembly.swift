//
//  CityTourHotelAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 30.08.2021.
//

import UIKit

protocol CityTourHotelAssemblyProtocol {
    func createModule(with userId: Int, _ tokens: SecurityTokens, _ cityTourInfoDelegate: CityTourInfoDelegateProtocol) -> HotelFeedViewController
}

class CityTourHotelAssembly: CityTourHotelAssemblyProtocol, DependencyRegistratorProtocol {
    func registerDependencies() {
        
        AppDelegate.container.register(service: HotelFeedPresenterProtocol.self, name: "CityTourHotelFeedPresenter") { (vc, router, interactor, cityTourInfoDelegate) -> HotelFeedPresenterProtocol in
            return CityTourHotelPresenter(view: vc, router: router, interactor: interactor, cityTourInfoDelegate: cityTourInfoDelegate)
        }
        
        AppDelegate.container.register(service: HotelFeedViewController.self, name: "CityTourHotelFeedViewController") { (userId: Int, tokens: SecurityTokens, cityTourInfoDelegate: CityTourInfoDelegateProtocol) -> HotelFeedViewController in
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
            
            guard let presenter = AppDelegate.container.resolve(
                    service: HotelFeedPresenterProtocol.self,
                    name: "CityTourHotelFeedPresenter",
                    arguments: vc, router, interactor, cityTourInfoDelegate
            ) else {
                return HotelFeedViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with userId: Int, _ tokens: SecurityTokens, _ cityTourInfoDelegate: CityTourInfoDelegateProtocol) -> HotelFeedViewController {
        return AppDelegate.container.resolve(service: HotelFeedViewController.self,
                                             name: "CityTourHotelFeedViewController",
                                             arguments: userId, tokens, cityTourInfoDelegate) ?? HotelFeedViewController()
    }
}
