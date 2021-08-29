//
//  TicketInfoProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import Foundation

protocol TicketInfoPresenterProtocol {
    func goBack()
    func loadInfo()
}

protocol TicketInfoInteractorProtocol {
    func loadInfo(complition: @escaping (Error?, Bool, TicketInfo?) -> Void)
    func deleteAuth()
}

protocol TicketInfoRouterProtocol {
    func goBack()
    func openAuth()
}

protocol TicketInfoAssemblyProtocol {
    func createModule(with ticketId: Int, _ tokens: SecurityTokens) -> TicketInfoViewController
}
