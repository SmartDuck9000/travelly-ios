//
//  HotelInfoPresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

class TicketInfoPresenter: TicketInfoPresenterProtocol {
    
    private weak var view: TicketInfoViewController!
    private let interactor: TicketInfoInteractorProtocol
    private let router: TicketInfoRouterProtocol
    
    init(view: TicketInfoViewController, interactor: TicketInfoInteractorProtocol, router: TicketInfoRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func goBack() {
        router.goBack()
    }
    
    func loadInfo() {
        interactor.loadInfo { (error, needAuth, data) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if needAuth {
                self.interactor.deleteAuth()
                self.router.openAuth()
            }
            
            guard let ticketInfo = data else { return }
            self.view.configure(with: ticketInfo)
        }
    }
}
