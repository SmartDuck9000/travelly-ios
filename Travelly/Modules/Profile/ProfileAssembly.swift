//
//  ProfileAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class ProfileAssembly: ProfileAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        
        AppDelegate.container.register(service: ProfileRouterProtocol.self, name: "ProfileRouter") { (vc) -> ProfileRouterProtocol in
            return ProfileRouter(view: vc)
        }
        
        AppDelegate.container.register(service: ProfileInteractorProtocol.self, name: "ProfileInteractor") { (networkService, dataStorage, imageLoader, userId, tokens) -> ProfileInteractorProtocol in
            return ProfileInteractor(networkService: networkService, dataStorage: dataStorage, imageLoader: imageLoader, userId: userId, tokens: tokens)
        }
        
        AppDelegate.container.register(service: ProfilePresenterProtocol.self, name: "ProfilePresenter") { (vc, router, interactor) -> ProfilePresenterProtocol in
            return ProfilePresenter(view: vc, router: router, interactor: interactor)
        }
        
        AppDelegate.container.register(service: ProfileViewController.self, name: "ProfileViewController") { (userId: Int, tokens: SecurityTokens) -> ProfileViewController in
            let vc = ProfileViewController()
            
            guard let router = AppDelegate.container.resolve(service: ProfileRouterProtocol.self, name: "ProfileRouter", argument: vc)
            else {
                return ProfileViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "NetworkProtocol") else {
                return ProfileViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return ProfileViewController()
            }
            
            guard let imageLoader = AppDelegate.container.resolve(service: ImageLoaderProtocol.self, name: "ImageLoaderProtocol") else {
                return ProfileViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: ProfileInteractorProtocol.self, name: "ProfileInteractor",
                                                                 arguments: networkService, dataStorage, imageLoader, userId, tokens)
            else {
                return ProfileViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: ProfilePresenterProtocol.self, name: "ProfilePresenter",
                                                                arguments: vc, router, interactor)
            else {
                return ProfileViewController()
            }
            
            vc.setPresenter(presenter)
            return vc
        }
    }
    
    func createModule(userId: Int, tokens: SecurityTokens) -> ProfileViewController {
        return AppDelegate.container.resolve(service: ProfileViewController.self, name: "ProfileViewController", arguments: userId, tokens) ?? ProfileViewController()
    }
}
