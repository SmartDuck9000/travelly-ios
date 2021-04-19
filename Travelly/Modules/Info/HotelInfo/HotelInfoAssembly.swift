//
//  HotelInfoAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class HotelInfoAssembly: HotelInfoAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: HotelInfoRouterProtocol.self, name: "HotelInfoRouter") { (vc) -> HotelInfoRouterProtocol in
            return HotelInfoRouter(view: vc)
        }
        
        AppDelegate.container.register(service: HotelInfoInteractorProtocol.self, name: "HotelInfoInteractor") { (networkService, dataStorage, hotelId, tokens) -> HotelInfoInteractor in
            return HotelInfoInteractor(networkService: networkService, dataStorage: dataStorage, hotelId: hotelId, tokens: tokens)
        }
        
        AppDelegate.container.register(service: HotelInfoPresenterProtocol.self, name: "HotelInfoPresenter") { (vc, interactor, router) -> HotelInfoPresenter in
            return HotelInfoPresenter(view: vc, interactor: interactor, router: router)
        }
        
        AppDelegate.container.register(service: HotelInfoViewController.self, name: "HotelInfoViewController") { (hotelId: Int, tokens: SecurityTokens) -> HotelInfoViewController in
            let vc = HotelInfoViewController()
            
            guard let router = AppDelegate.container.resolve(service: HotelInfoRouterProtocol.self, name: "HotelInfoRouter", argument: vc)
            else {
                return HotelInfoViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return HotelInfoViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return HotelInfoViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: HotelInfoInteractorProtocol.self, name: "HotelInfoInteractor", arguments: networkService, dataStorage, hotelId, tokens)
            else {
                return HotelInfoViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: HotelInfoPresenterProtocol.self, name: "HotelInfoPresenter",
                                                                arguments: vc, interactor, router)
            else {
                return HotelInfoViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with hotelId: Int, _ tokens: SecurityTokens) -> HotelInfoViewController {
        return AppDelegate.container.resolve(service: HotelInfoViewController.self,
                                             name: "HotelInfoViewController",
                                             arguments: hotelId, tokens) ?? HotelInfoViewController()
    }
}
