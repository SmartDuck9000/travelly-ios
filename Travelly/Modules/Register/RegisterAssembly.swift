//
//  RegisterAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.02.2021.
//

import UIKit

class RegisterAssembly: RegisterAssemblyProtocol, DependencyRegistratorProtocol {
    func registerDependencies() {
        AppDelegate.container.register(service: RegisterRouterProtocol.self, name: "RegisterRouter") { (vc) -> RegisterRouterProtocol in
            return RegisterRouter(view: vc)
        }
        
        AppDelegate.container.register(service: RegisterInteractorProtocol.self, name: "RegisterInteractor") { (networkService, dataStorageService) -> RegisterInteractorProtocol in
            return RegisterInteractor(networkService: networkService, dataStorageService: dataStorageService)
        }
        
        AppDelegate.container.register(service: RegisterPresenterProtocol.self, name: "RegisterPresenter") { (vc, router, interactor) -> RegisterPresenterProtocol in
            return RegisterPresenter(view: vc, router: router, interactor: interactor)
        }
        
        AppDelegate.container.register(service: RegisterViewController.self, name: "RegisterViewController") { () -> RegisterViewController in
            let vc = RegisterViewController()
            
            guard let router = AppDelegate.container.resolve(service: RegisterRouterProtocol.self, name: "RegisterRouter", argument: vc)
            else {
                return RegisterViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "NetworkProtocol") else {
                return RegisterViewController()
            }
            
            guard let dataStorageService = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "DataStorageProtocol") else {
                return RegisterViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: RegisterInteractorProtocol.self, name: "RegisterInteractor",
                                                                 arguments: networkService, dataStorageService)
            else {
                return RegisterViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: RegisterPresenterProtocol.self, name: "RegisterPresenter",
                                                                arguments: vc, router, interactor)
            else {
                return RegisterViewController()
            }
            
            interactor.setPresenter(presenter)
            vc.setPresenter(presenter)
            return vc
        }
    }
    
    func createModule() -> RegisterViewController {
        return AppDelegate.container.resolve(service: RegisterViewController.self, name: "RegisterViewController") ?? RegisterViewController()
    }
}
