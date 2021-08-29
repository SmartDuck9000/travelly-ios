//
//  EventInfoAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class EventInfoAssembly: EventInfoAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: EventInfoRouterProtocol.self, name: "EventInfoRouter") { (vc) -> EventInfoRouterProtocol in
            return EventInfoRouter(view: vc)
        }
        
        AppDelegate.container.register(service: EventInfoInteractorProtocol.self, name: "EventInfoInteractor") { (networkService, dataStorage, eventId, tokens) -> EventInfoInteractor in
            return EventInfoInteractor(networkService: networkService, dataStorage: dataStorage, eventId: eventId, tokens: tokens)
        }
        
        AppDelegate.container.register(service: EventInfoPresenterProtocol.self, name: "EventInfoPresenter") { (vc, interactor, router) -> EventInfoPresenter in
            return EventInfoPresenter(view: vc, interactor: interactor, router: router)
        }
        
        AppDelegate.container.register(service: EventInfoViewController.self, name: "EventInfoViewController") { (eventId: Int, tokens: SecurityTokens) -> EventInfoViewController in
            let vc = EventInfoViewController()
            
            guard let router = AppDelegate.container.resolve(service: EventInfoRouterProtocol.self, name: "EventInfoRouter", argument: vc)
            else {
                return EventInfoViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return EventInfoViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return EventInfoViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: EventInfoInteractorProtocol.self, name: "EventInfoInteractor", arguments: networkService, dataStorage, eventId, tokens)
            else {
                return EventInfoViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: EventInfoPresenterProtocol.self, name: "EventInfoPresenter",
                                                                arguments: vc, interactor, router)
            else {
                return EventInfoViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with eventId: Int, _ tokens: SecurityTokens) -> EventInfoViewController {
        return AppDelegate.container.resolve(service: EventInfoViewController.self,
                                             name: "EventInfoViewController",
                                             arguments: eventId, tokens) ?? EventInfoViewController()
    }
}
