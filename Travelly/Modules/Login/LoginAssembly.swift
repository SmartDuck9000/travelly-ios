//
//  LoginAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 26.02.2021.
//

import UIKit

class LoginAssembly: LoginAssemblyProtocol, DependencyRegistratorProtocol {
    func registerDependencies() {
        AppDelegate.container.register(service: LoginRouterProtocol.self, name: "LoginRouter") { (vc) -> LoginRouterProtocol in
            return LoginRouter(view: vc)
        }
        
        AppDelegate.container.register(service: LoginInteractorProtocol.self, name: "LoginInteractor") { (networkService, dataStorage) -> LoginInteractorProtocol in
            return LoginInteractor(networkService: networkService, dataStorage: dataStorage)
        }
        
        AppDelegate.container.register(service: LoginPresenterProtocol.self, name: "LoginPresenter") { (vc, router, interactor) -> LoginPresenterProtocol in
            return LoginPresenter(view: vc, router: router, interactor: interactor)
        }
        
        AppDelegate.container.register(service: LoginViewController.self, name: "LoginViewController") { () -> LoginViewController in
            let vc = LoginViewController()
            
            guard let router = AppDelegate.container.resolve(service: LoginRouterProtocol.self, name: "LoginRouter", argument: vc)
            else {
                return LoginViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return LoginViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return LoginViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: LoginInteractorProtocol.self, name: "LoginInteractor",
                                                                 arguments: networkService, dataStorage)
            else {
                return LoginViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: LoginPresenterProtocol.self, name: "LoginPresenter",
                                                                arguments: vc, router, interactor)
            else {
                return LoginViewController()
            }
            
            interactor.setPresenter(presenter)
            vc.setPresenter(presenter)
            return vc
        }
    }
    
    func createModule() -> LoginViewController {
        return AppDelegate.container.resolve(service: LoginViewController.self, name: "LoginViewController") ?? LoginViewController()
    }
}

