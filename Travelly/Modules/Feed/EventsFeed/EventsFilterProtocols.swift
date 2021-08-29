//
//  EventsFilterProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol EventsFilterPresenterProtocol {
    func setFilterView(_ filterView: EventsFeedFilterViewController)
    func setupFilters()
    func saveFilters()
}

protocol EventsFilterAssemblyProtocol {
    func createModule(with presenter: EventsFilterPresenterProtocol) -> EventsFeedFilterViewController
}
