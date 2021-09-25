//
//  TicketInfoAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class TicketInfoAssembly: TicketInfoAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: TicketInfoRouterProtocol.self, name: "TicketInfoRouter") { (vc) -> TicketInfoRouterProtocol in
            return TicketInfoRouter(view: vc)
        }
        
        AppDelegate.container.register(service: TicketInfoInteractorProtocol.self, name: "TicketInfoInteractor") { (networkService, dataStorage, ticketId, tokens) -> TicketInfoInteractor in
            return TicketInfoInteractor(networkService: networkService, dataStorage: dataStorage, ticketId: ticketId, tokens: tokens)
        }
        
        AppDelegate.container.register(service: TicketInfoPresenterProtocol.self, name: "TicketInfoPresenter") { (vc, interactor, router) -> TicketInfoPresenter in
            return TicketInfoPresenter(view: vc, interactor: interactor, router: router)
        }
        
        AppDelegate.container.register(service: TicketInfoViewController.self, name: "TicketInfoViewController") { (ticketId: Int, tokens: SecurityTokens) -> TicketInfoViewController in
            let vc = TicketInfoViewController()
            
            guard let router = AppDelegate.container.resolve(service: TicketInfoRouterProtocol.self, name: "TicketInfoRouter", argument: vc)
            else {
                return TicketInfoViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return TicketInfoViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return TicketInfoViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: TicketInfoInteractorProtocol.self, name: "TicketInfoInteractor", arguments: networkService, dataStorage, ticketId, tokens)
            else {
                return TicketInfoViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: TicketInfoPresenterProtocol.self, name: "TicketInfoPresenter", arguments: vc, interactor, router)
            else {
                return TicketInfoViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with ticketId: Int, _ tokens: SecurityTokens) -> TicketInfoViewController {
        return AppDelegate.container.resolve(service: TicketInfoViewController.self,
                                             name: "TicketInfoViewController",
                                             arguments: ticketId, tokens) ?? TicketInfoViewController()
    }
}
