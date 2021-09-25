//
//  CityTourTicketsAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 30.08.2021.
//

import UIKit

protocol CityTourTicketsAssemblyProtocol {
    func createArrivalModule(
        with userId: Int,
        _ tokens: SecurityTokens,
        _ cityTourInfoDelegate: CityTourInfoDelegateProtocol
    ) -> TicketsFeedViewController
    
    func createDepartureModule(
        with userId: Int,
        _ tokens: SecurityTokens,
        _ cityTourInfoDelegate: CityTourInfoDelegateProtocol
    ) -> TicketsFeedViewController
}

class CityTourTicketsAssembly: CityTourTicketsAssemblyProtocol, DependencyRegistratorProtocol {
    func registerDependencies() {
        
        AppDelegate.container.register(service: TicketsFeedPresenterProtocol.self, name: "CityTourArrivalTicketsFeedPresenter") { (vc, router, interactor, cityTourInfoDelegate) -> TicketsFeedPresenterProtocol in
            return CityTourArrivalTicketPresenter(view: vc, router: router, interactor: interactor, cityTourInfoDelegate: cityTourInfoDelegate)
        }
        
        AppDelegate.container.register(service: TicketsFeedViewController.self, name: "CityTourArrivalTicketFeedViewController") { (userId: Int, tokens: SecurityTokens, cityTourInfoDelegate: CityTourInfoDelegateProtocol) -> TicketsFeedViewController in
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
            
            guard let presenter = AppDelegate.container.resolve(
                    service: TicketsFeedPresenterProtocol.self,
                    name: "CityTourArrivalTicketsFeedPresenter",
                    arguments: vc, router, interactor, cityTourInfoDelegate
            ) else {
                return TicketsFeedViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
        
        AppDelegate.container.register(service: TicketsFeedPresenterProtocol.self, name: "CityTourDepartureTicketsFeedPresenter") { (vc, router, interactor, cityTourInfoDelegate) -> TicketsFeedPresenterProtocol in
            return CityTourDepartureTicketPresenter(view: vc, router: router, interactor: interactor, cityTourInfoDelegate: cityTourInfoDelegate)
        }
        
        AppDelegate.container.register(service: TicketsFeedViewController.self, name: "CityTourDepartureTicketFeedViewController") { (userId: Int, tokens: SecurityTokens, cityTourInfoDelegate: CityTourInfoDelegateProtocol) -> TicketsFeedViewController in
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
            
            guard let presenter = AppDelegate.container.resolve(
                    service: TicketsFeedPresenterProtocol.self,
                    name: "CityTourDepartureTicketsFeedPresenter",
                    arguments: vc, router, interactor, cityTourInfoDelegate
            ) else {
                return TicketsFeedViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createArrivalModule(
        with userId: Int,
        _ tokens: SecurityTokens,
        _ cityTourInfoDelegate: CityTourInfoDelegateProtocol
    ) -> TicketsFeedViewController {
        return AppDelegate.container.resolve(
            service: TicketsFeedViewController.self,
            name: "CityTourArrivalTicketFeedViewController",
            arguments: userId, tokens, cityTourInfoDelegate
        ) ?? TicketsFeedViewController()
    }
    
    func createDepartureModule(
        with userId: Int,
        _ tokens: SecurityTokens,
        _ cityTourInfoDelegate: CityTourInfoDelegateProtocol
    ) -> TicketsFeedViewController {
        return AppDelegate.container.resolve(
            service: TicketsFeedViewController.self,
            name: "CityTourDepartureTicketFeedViewController",
            arguments: userId, tokens, cityTourInfoDelegate
        ) ?? TicketsFeedViewController()
    }
}
