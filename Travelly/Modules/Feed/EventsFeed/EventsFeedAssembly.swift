//
//  EventsFeedAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class EventsFeedAssembly: EventsFeedAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: EventsFeedRouterProtocol.self, name: "EventsFeedRouter") { (vc) -> EventsFeedRouterProtocol in
            return EventsFeedRouter(view: vc)
        }
        
        AppDelegate.container.register(service: EventsFeedInteractorProtocol.self, name: "EventsFeedInteractor") { (networkService, dataStorage, userId, tokens) -> EventsFeedInteractorProtocol in
            return EventsFeedInteractor(networkService: networkService, dataStorage: dataStorage, userId: userId, tokens: tokens)
        }
        
        AppDelegate.container.register(service: EventsFeedPresenterProtocol.self, name: "EventsFeedPresenter") { (vc, router, interactor) -> EventsFeedPresenterProtocol in
            return EventsFeedPresenter(view: vc, router: router, interactor: interactor)
        }
        
        AppDelegate.container.register(service: EventsFeedViewController.self, name: "EventsFeedViewController") { (userId: Int, tokens: SecurityTokens) -> EventsFeedViewController in
            let vc = EventsFeedViewController()
            
            guard let router = AppDelegate.container.resolve(service: EventsFeedRouterProtocol.self, name: "EventsFeedRouter", argument: vc)
            else {
                return EventsFeedViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return EventsFeedViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return EventsFeedViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: EventsFeedInteractorProtocol.self, name: "EventsFeedInteractor", arguments: networkService, dataStorage, userId, tokens)
            else {
                return EventsFeedViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: EventsFeedPresenterProtocol.self, name: "EventsFeedPresenter", arguments: vc, router, interactor)
            else {
                return EventsFeedViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> EventsFeedViewController {
        return AppDelegate.container.resolve(service: EventsFeedViewController.self,
                                             name: "EventsFeedViewController",
                                             arguments: userId, tokens) ?? EventsFeedViewController()
    }
}
