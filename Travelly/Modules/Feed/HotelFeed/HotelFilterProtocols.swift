//
//  HotelFilterProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol HotelFilterPresenterProtocol {
    func setFilterView(_ filterView: HotelFeedFilterViewController)
    func setupFilters()
    func saveFilters()
}

protocol HotelFilterAssemblyProtocol {
    func createModule(with presenter: HotelFilterPresenterProtocol) -> HotelFeedFilterViewController
}
