//
//  TicketsFeedAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class TicketsFeedAssembly: TicketsFeedAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: TicketsFeedRouterProtocol.self, name: "TicketsFeedRouter") { (vc) -> TicketsFeedRouterProtocol in
            return TicketsFeedRouter(view: vc)
        }
        
        AppDelegate.container.register(service: TicketsFeedInteractorProtocol.self, name: "TicketsFeedInteractor") { (networkService, dataStorage, userId, tokens) -> TicketsFeedInteractorProtocol in
            return TicketsFeedInteractor(networkService: networkService, dataStorage: dataStorage, userId: userId, tokens: tokens)
        }
        
        AppDelegate.container.register(service: TicketsFeedPresenterProtocol.self, name: "TicketsFeedPresenter") { (vc, router, interactor) -> TicketsFeedPresenterProtocol in
            return TicketsFeedPresenter(view: vc, router: router, interactor: interactor)
        }
        
        AppDelegate.container.register(service: TicketsFeedViewController.self, name: "TicketsFeedViewController") { (userId: Int, tokens: SecurityTokens) -> TicketsFeedViewController in
            let vc = TicketsFeedViewController()
            
            guard let router = AppDelegate.container.resolve(service: TicketsFeedRouterProtocol.self, name: "TicketsFeedRouter", argument: vc)
            else {
                return TicketsFeedViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return TicketsFeedViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return TicketsFeedViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: TicketsFeedInteractorProtocol.self, name: "TicketsFeedInteractor", arguments: networkService, dataStorage, userId, tokens)
            else {
                return TicketsFeedViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: TicketsFeedPresenterProtocol.self, name: "TicketsFeedPresenter",
                                                                arguments: vc, router, interactor)
            else {
                return TicketsFeedViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> TicketsFeedViewController {
        return AppDelegate.container.resolve(service: TicketsFeedViewController.self,
                                             name: "TicketsFeedViewController",
                                             arguments: userId, tokens) ?? TicketsFeedViewController()
    }
}
