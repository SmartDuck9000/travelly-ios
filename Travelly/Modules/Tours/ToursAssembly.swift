//
//  ToursAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import UIKit

protocol ToursAssemblyProtocol {
    func createModule(userId: Int, tokens: SecurityTokens) -> ToursViewController
}

class ToursAssembly: ToursAssemblyProtocol, DependencyRegistratorProtocol {
    func registerDependencies() {
        
        AppDelegate.container.register(
            service: ToursPresenterProtocol.self,
            name: "ToursPresenter"
        ) { (view, networkService, dataStorage, tokens, userId) -> ToursPresenterProtocol in
            return ToursPresenter(
                view: view,
                networkService: networkService,
                dataStorage: dataStorage,
                tokens: tokens,
                userId: userId
            )
        }
        
        AppDelegate.container.register(
            service: ToursViewController.self,
            name: "ToursViewController"
        ) { (userId: Int, tokens: SecurityTokens) -> ToursViewController in
            let vc = ToursViewController()
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return ToursViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return ToursViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(
                    service: ToursPresenterProtocol.self,
                    name: "ToursPresenter",
                    arguments: vc, networkService, dataStorage, tokens, userId
            )
            else {
                return ToursViewController()
            }
            
            vc.presenter = presenter
            return vc
        }
    }
    
    func createModule(userId: Int, tokens: SecurityTokens) -> ToursViewController {
        return AppDelegate.container.resolve(service: ToursViewController.self, name: "ToursViewController", arguments: userId, tokens) ?? ToursViewController()
    }
}
