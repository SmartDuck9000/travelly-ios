//
//  AuthAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 16.02.2021.
//

import Foundation

class AuthAssembly: AuthAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: AuthRouterProtocol.self, name: "AuthRouter") { (vc) -> AuthRouterProtocol in
            return AuthRouter(view: vc)
        }
        
        AppDelegate.container.register(service: AuthPresenterProtocol.self, name: "AuthPresenter") { (vc, router) -> AuthPresenterProtocol in
            return AuthPresenter(view: vc, router: router)
        }
        
        AppDelegate.container.register(service: AuthViewController.self, name: "AuthViewController") { () -> AuthViewController in
            let vc = AuthViewController()
            
            guard let router = AppDelegate.container.resolve(service: AuthRouterProtocol.self, name: "AuthRouter", argument: vc) else {
                return AuthViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: AuthPresenterProtocol.self,
                                                                name: "AuthPresenter",
                                                                arguments: vc, router)
            else {
                return AuthViewController()
            }
            
            vc.setPresenter(presenter)
            return vc
        }
    }
    
    func createModule() -> AuthViewController {
        return AppDelegate.container.resolve(service: AuthViewController.self, name: "AuthViewController") ?? AuthViewController()
    }
}
