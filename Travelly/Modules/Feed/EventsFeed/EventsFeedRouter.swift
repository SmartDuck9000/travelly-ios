//
//  EventsFeedRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import UIKit

class EventsFeedRouter: EventsFeedRouterProtocol {
    private weak var view: EventsFeedViewController!
    
    init(view: EventsFeedViewController) {
        self.view = view
    }
    
    func goBack() {
        view.navigationController?.popViewController(animated: true)
    }
    
    func openFullInfo(with id: Int, _ tokens: SecurityTokens) {
        let eventsInfoAssembly: EventInfoAssemblyProtocol = EventInfoAssembly()
        let eventsInfoView = eventsInfoAssembly.createModule(with: id, tokens)
        view.navigationController?.pushViewController(eventsInfoView, animated: true)
    }
    
    func openFilter(with presenter: EventsFilterPresenterProtocol) {
        let filterAssembly: EventsFilterAssemblyProtocol = EventsFilterAssembly()
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
