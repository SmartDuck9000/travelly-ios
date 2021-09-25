//
//  EventsFeedProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol EventsFeedPresenterProtocol {
    func loadFeed()
    func reloadFeed()
    func eventsCount() -> Int
    func configureEventsCell(_ cell: EventsTableViewCell, at index: Int)
    func selectEvent(at index: Int)
    
    func goBack()
    func openFilter()
}

protocol EventsFeedInteractorProtocol {
    func loadFeed(complition: @escaping (Error?, Bool, Bool) -> Void)
    func setNeedReload(_ needReload: Bool)
    
    func eventsCount() -> Int
    func getEventsData(at index: Int) -> EventsData
    
    func getTokens() -> SecurityTokens
    
    func getEventsFilterData() -> EventsFilter
    func setEventsFilterData(_ eventsFilter: EventsFilter)
    
    func deleteAuthData()
}

protocol EventsFeedRouterProtocol {
    func goBack()
    func openFullInfo(with id: Int, _ tokens: SecurityTokens)
    func openFilter(with presenter: EventsFilterPresenterProtocol)
    
    func openAuth()
}

protocol EventsFeedAssemblyProtocol {
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> EventsFeedViewController
}
