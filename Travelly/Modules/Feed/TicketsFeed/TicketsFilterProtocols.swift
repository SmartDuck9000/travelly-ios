//
//  TicketsFilterProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol TicketsFilterPresenterProtocol {
    func setFilterView(_ filterView: TicketsFeedFilterViewController)
    func setupFilters()
    func saveFilters()
}

protocol TicketsFilterAssemblyProtocol {
    func createModule(with presenter: TicketsFilterPresenterProtocol) -> TicketsFeedFilterViewController
}
