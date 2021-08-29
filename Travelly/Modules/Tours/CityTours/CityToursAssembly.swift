//
//  CityToursAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import Foundation

protocol CityToursAssemblyProtocol {
    func createModule(tourId: Int, tokens: SecurityTokens) -> CityToursViewController
}

class CityToursAssembly: CityToursAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(
            service: CityToursPresenterProtocol.self,
            name: "CityToursPresenter"
        ) { (view, networkService, dataStorage, tokens, tourId) -> CityToursPresenterProtocol in
            return CityToursPresenter(
                view: view,
                networkService: networkService,
                dataStorage: dataStorage,
                tokens: tokens,
                tour_id: tourId
            )
        }
        
        AppDelegate.container.register(
            service: CityToursViewController.self,
            name: "CityToursViewController"
        ) { (tourId: Int, tokens: SecurityTokens) -> CityToursViewController in
            let vc = CityToursViewController()
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return CityToursViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return CityToursViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(
                    service: CityToursPresenterProtocol.self,
                    name: "CityToursPresenter",
                    arguments: vc, networkService, dataStorage, tokens, tourId
            )
            else {
                return CityToursViewController()
            }
            
            vc.presenter = presenter
            return vc
        }
    }
    
    func createModule(tourId: Int, tokens: SecurityTokens) -> CityToursViewController {
        return AppDelegate.container.resolve(service: CityToursViewController.self, name: "CityToursViewController", arguments: tourId, tokens) ?? CityToursViewController()
    }
}
