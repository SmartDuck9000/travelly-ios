//
//  ServicesRegistrator.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//

import UIKit

class ServicesRegistrator: DependencyRegistratorProtocol {
    func registerDependencies() {
        AppDelegate.container.register(service: NetworkProtocol.self, name: "AlamofireNetworkProtocol") { () in
            return AlamofireNetworkService()
        }
        
        AppDelegate.container.register(service: DataStorageProtocol.self, name: "RealmDataStorage") { () in
            return RealmDataStorage()
        }
        
        AppDelegate.container.register(service: ImageLoaderProtocol.self, name: "ImageLoaderProtocol") { () in
            return KingfisherImageLoader()
        }
        
        AppDelegate.container.register(service: ImageHostingServiceProtocol.self, name: "CloudinaryImageHostingService") { () in
            return CloudinaryImageHostingService()
        }
    }
}
