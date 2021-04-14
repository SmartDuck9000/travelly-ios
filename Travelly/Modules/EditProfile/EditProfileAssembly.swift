//
//  EditProfileAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 03.04.2021.
//

import UIKit

class EditProfileAssembly: EditProfileAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        AppDelegate.container.register(service: EditProfileRouterProtocol.self, name: "EditProfileRouter") { (vc) -> EditProfileRouterProtocol in
            return EditProfileRouter(view: vc)
        }
        
        AppDelegate.container.register(service: EditProfileInteractorProtocol.self, name: "EditProfileInteractor") { (networkService, dataStorage, imageLoader, imageHosting, userId, tokens, profileData) -> EditProfileInteractorProtocol in
            return EditProfileInteractor(networkService: networkService, dataStorage: dataStorage, imageLoader: imageLoader, imageHosting: imageHosting, userId: userId, tokens: tokens, profileData: profileData)
        }
        
        AppDelegate.container.register(service: EditProfilePresenterProtocol.self, name: "EditProfilePresenter") { (vc, router, interactor) -> EditProfilePresenterProtocol in
            return EditProfilePresenter(view: vc, router: router, interactor: interactor)
        }
        
        AppDelegate.container.register(service: EditProfileViewController.self, name: "EditProfileViewController") { (userId: Int, tokens: SecurityTokens, profileData: ProfileData) -> EditProfileViewController in
            let vc = EditProfileViewController()
            
            guard let router = AppDelegate.container.resolve(service: EditProfileRouterProtocol.self, name: "EditProfileRouter", argument: vc)
            else {
                return EditProfileViewController()
            }
            
            guard let networkService = AppDelegate.container.resolve(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") else {
                return EditProfileViewController()
            }
            
            guard let dataStorage = AppDelegate.container.resolve(service: DataStorageProtocol.self, name: "RealmDataStorage") else {
                return EditProfileViewController()
            }
            
            guard let imageLoader = AppDelegate.container.resolve(service: ImageLoaderProtocol.self, name: "ImageLoaderProtocol") else {
                return EditProfileViewController()
            }
            
            guard let imageHosting = AppDelegate.container.resolve(service: ImageHostingServiceProtocol.self, name: "CloudinaryImageHostingService") else {
                return EditProfileViewController()
            }
            
            guard let interactor = AppDelegate.container.resolve(service: EditProfileInteractorProtocol.self, name: "EditProfileInteractor", arguments: networkService, dataStorage, imageLoader, imageHosting, userId, tokens, profileData)
            else {
                return EditProfileViewController()
            }
            
            guard let presenter = AppDelegate.container.resolve(service: EditProfilePresenterProtocol.self, name: "EditProfilePresenter",
                                                                arguments: vc, router, interactor)
            else {
                return EditProfileViewController()
            }
            
            vc.set(presenter: presenter)
            return vc
        }
    }
    
    func createModule(with userId: Int, _ tokens: SecurityTokens, _ profileData: ProfileData) -> EditProfileViewController {
        return AppDelegate.container.resolve(service: EditProfileViewController.self,
                                             name: "EditProfileViewController",
                                             arguments: userId, tokens, profileData) ?? EditProfileViewController()
    }
}
