//
//  EventsFilterAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class EventsFilterAssembly: EventsFilterAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        
        AppDelegate.container.register(service: EventsFeedFilterViewController.self, name: "EventsFeedFilterViewController") { (presenter: EventsFilterPresenterProtocol) -> EventsFeedFilterViewController in
            let vc = EventsFeedFilterViewController()
            
            vc.set(presenter)
            presenter.setFilterView(vc)
            return vc
        }
    }
    
    func createModule(with presenter: EventsFilterPresenterProtocol) -> EventsFeedFilterViewController {
        return AppDelegate.container.resolve(service: EventsFeedFilterViewController.self,
                                             name: "EventsFeedFilterViewController",
                                             argument: presenter) ?? EventsFeedFilterViewController()
    }
}
