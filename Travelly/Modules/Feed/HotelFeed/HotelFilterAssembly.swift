//
//  HotelFilterAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class HotelFilterAssembly: HotelFilterAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        
        AppDelegate.container.register(service: HotelFeedFilterViewController.self, name: "HotelFeedFilterViewController") { (presenter: HotelFilterPresenterProtocol) -> HotelFeedFilterViewController in
            let vc = HotelFeedFilterViewController()
            
            vc.set(presenter)
            presenter.setFilterView(vc)
            return vc
        }
    }
    
    func createModule(with presenter: HotelFilterPresenterProtocol) -> HotelFeedFilterViewController {
        return AppDelegate.container.resolve(service: HotelFeedFilterViewController.self,
                                             name: "HotelFeedFilterViewController",
                                             argument: presenter) ?? HotelFeedFilterViewController()
    }
}
