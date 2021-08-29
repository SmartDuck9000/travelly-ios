//
//  TicketsFeedProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol TicketsFeedPresenterProtocol {
    func loadFeed()
    func reloadFeed()
    func ticketsCount() -> Int
    func configureTicketsCell(_ cell: TicketsTableViewCell, at index: Int)
    func selectTicket(at index: Int)
    
    func goBack()
    func openFilter()
}

protocol TicketsFeedInteractorProtocol {
    func loadFeed(complition: @escaping (Error?, Bool, Bool) -> Void)
    func setNeedReload(_ needReload: Bool)
    
    func ticketsCount() -> Int
    func getTicketsData(at index: Int) -> TicketsData
    
    func getTokens() -> SecurityTokens
    
    func getTicketsFilterData() -> TicketsFilter
    func setTicketsFilterData(_ ticketsFilter: TicketsFilter)
    
    func deleteAuthData()
}

protocol TicketsFeedRouterProtocol {
    func goBack()
    func openFullInfo(with id: Int, _ tokens: SecurityTokens)
    func openFilter(with presenter: TicketsFilterPresenterProtocol)
    
    func openAuth()
}

protocol TicketsFeedAssemblyProtocol {
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> TicketsFeedViewController
}
