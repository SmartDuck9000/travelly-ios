//
//  RestaurantsFilterAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class RestaurantsFilterAssembly: RestaurantsFilterAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        
        AppDelegate.container.register(service: RestaurantsFeedFilterViewController.self, name: "RestaurantsFeedFilterViewController") { (presenter: RestaurantsFilterPresenterProtocol) -> RestaurantsFeedFilterViewController in
            let vc = RestaurantsFeedFilterViewController()
            
            vc.set(presenter)
            presenter.setFilterView(vc)
            return vc
        }
    }
    
    func createModule(with presenter: RestaurantsFilterPresenterProtocol) -> RestaurantsFeedFilterViewController {
        return AppDelegate.container.resolve(service: RestaurantsFeedFilterViewController.self,
                                             name: "RestaurantsFeedFilterViewController",
                                             argument: presenter) ?? RestaurantsFeedFilterViewController()
    }
}
