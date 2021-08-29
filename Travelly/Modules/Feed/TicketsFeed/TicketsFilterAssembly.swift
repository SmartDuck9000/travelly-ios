//
//  TicketsFilterAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class TicketsFilterAssembly: TicketsFilterAssemblyProtocol, DependencyRegistratorProtocol {
    
    func registerDependencies() {
        
        AppDelegate.container.register(service: TicketsFeedFilterViewController.self, name: "TicketsFeedFilterViewController") { (presenter: TicketsFilterPresenterProtocol) -> TicketsFeedFilterViewController in
            let vc = TicketsFeedFilterViewController()
            
            vc.set(presenter)
            presenter.setFilterView(vc)
            return vc
        }
    }
    
    func createModule(with presenter: TicketsFilterPresenterProtocol) -> TicketsFeedFilterViewController {
        return AppDelegate.container.resolve(service: TicketsFeedFilterViewController.self,
                                             name: "TicketsFeedFilterViewController",
                                             argument: presenter) ?? TicketsFeedFilterViewController()
    }
}
