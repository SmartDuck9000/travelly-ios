//
//  RestaurantsFilterProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol RestaurantsFilterPresenterProtocol {
    func setFilterView(_ filterView: RestaurantsFeedFilterViewController)
    func setupFilters()
    func saveFilters()
}

protocol RestaurantsFilterAssemblyProtocol {
    func createModule(with presenter: RestaurantsFilterPresenterProtocol) -> RestaurantsFeedFilterViewController
}
