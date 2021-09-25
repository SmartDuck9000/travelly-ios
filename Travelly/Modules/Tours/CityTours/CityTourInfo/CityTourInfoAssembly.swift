//
//  ProfileAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class CityTourInfoAssembly: CityTourInfoAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        
        AppDelegate.container.register(
            service: CityTourInfoRouterProtocol.self,
            name: "CityTourInfoRouter"
        ) { (vc) -> CityTourInfoRouterProtocol in
            return CityTourInfoRouter(view: vc)
        }
        
        AppDelegate.container.register(
            service: CityTourInfoOptionsInteractorProtocol.self,
            name: "CityTourInfoOptionsInteractor"
        ) {
            return CityTourInfoOptionsInteractor()
        }
        
        AppDelegate.container.register(
            service: CityTourInfoDelegateProtocol.self,
            name: "CityTourInfoDelegate"
        ) { (cityTourModel, postedCityTourData, networkService, dataStorage, tokens, vc) -> CityTourInfoDelegateProtocol in
            return CityTourInfoDelegate(
                cityTourModel: cityTourModel,
                postedCityTourData: postedCityTourData,
                networkService: networkService,
                dataStorage: dataStorage,
                tokens: tokens,
                view: vc
            )
        }
        
        AppDelegate.container.register(
            service: CityTourInfoPresenterProtocol.self,
            name: "CityTourInfoPresenter"
        ) { (vc, router, optionsInteractor, tokens, cityTourData, postedCityTourData, cityTourInfoDelegate) -> CityTourInfoPresenterProtocol in
            return CityTourInfoPresenter(
                view: vc,
                router: router,
                optionsInteractor: optionsInteractor,
                tokens: tokens,
                cityTourData: cityTourData,
                postedCityTourData: postedCityTourData,
                cityTourInfoDelegate: cityTourInfoDelegate
            )
        }
        
        AppDelegate.container.register(
            service: CityTourInfoViewController.self,
            name: "CityTourInfoViewController"
        ) { (cityTourData: CityTourModel, postedCityTourData: PostedCityTourModel, tokens: SecurityTokens) -> CityTourInfoViewController in
            let vc = CityTourInfoViewController()
            
            guard let router = AppDelegate.container.resolve(
                service: CityTourInfoRouterProtocol.self,
                name: "CityTourInfoRouter",
                argument: vc
            ) else {
                return CityTourInfoViewController()
            }
            
            guard let optionsInteractor = AppDelegate.container.resolve(
                service: CityTourInfoOptionsInteractorProtocol.self,
                name: "CityTourInfoOptionsInteractor"
            ) else {
                return CityTourInfoViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return CityTourInfoViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return CityTourInfoViewController()
            }
            
            guard let cityTourInfoDelegate = AppDelegate.container.resolve(
                service: CityTourInfoDelegateProtocol.self,
                name: "CityTourInfoDelegate",
                arguments: cityTourData, postedCityTourData, networkService, dataStorage, tokens, vc
            ) else {
                return CityTourInfoViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(
                service: CityTourInfoPresenterProtocol.self,
                name: "CityTourInfoPresenter",
                arguments: vc, router, optionsInteractor, tokens, cityTourData, postedCityTourData, cityTourInfoDelegate
            ) else {
                return CityTourInfoViewController()
            }
            
            vc.presenter = presenter
            return vc
        }
    }
    
    func createModule(
        cityTourData: CityTourModel,
        postedCityTourData: PostedCityTourModel,
        tokens: SecurityTokens
    ) -> CityTourInfoViewController {
        return AppDelegate.container.resolve(
            service: CityTourInfoViewController.self,
            name: "CityTourInfoViewController",
            arguments: cityTourData, postedCityTourData, tokens
        ) ?? CityTourInfoViewController()
    }
}
