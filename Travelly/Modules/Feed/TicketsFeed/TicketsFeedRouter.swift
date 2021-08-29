//
//  TicketsFeedRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class TicketsFeedRouter: TicketsFeedRouterProtocol {
    private weak var view: TicketsFeedViewController!
    
    init(view: TicketsFeedViewController) {
        self.view = view
    }
    
    func goBack() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func openFullInfo(with id: Int, _ tokens: SecurityTokens) {
        let ticketsInfoAssembly: TicketInfoAssemblyProtocol = TicketInfoAssembly()
        let ticketsInfoView = ticketsInfoAssembly.createModule(with: id, tokens)
        view.navigationController?.pushViewController(ticketsInfoView, animated: true)
    }
    
    func openFilter(with presenter: TicketsFilterPresenterProtocol) {
        let filterAssembly: TicketsFilterAssemblyProtocol = TicketsFilterAssembly()
        let filterView = filterAssembly.createModule(with: presenter)
        view.navigationController?.pushViewController(filterView, animated: true)
    }
    
    func openAuth() {
        let assembly: AuthAssemblyProtocol = AuthAssembly()
        let authView: AuthViewController = assembly.createModule()
        authView.modalPresentationStyle = .fullScreen
        view.present(authView, animated: false, completion: nil)
    }
}
