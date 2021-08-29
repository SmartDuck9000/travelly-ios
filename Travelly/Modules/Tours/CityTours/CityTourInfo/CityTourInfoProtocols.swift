//
//  UserProfileProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

protocol CityTourInfoPresenterProtocol {
    var cityTourData: CityTourModel { get }
    
    func optionsCount() -> Int
    func configureOptionCell(_ cell: CityTourInfoOptionTableViewCell, at index: Int)
    func selectOption(at index: Int)
}

protocol CityTourInfoOptionsInteractorProtocol {
    func optionsCount() -> Int
    func getCityTourInfoOptionData(at index: Int) -> CityTourInfoOptionData?
}

protocol CityTourInfoRouterProtocol {
    func openHotel(with cityTourData: CityTourModel, tokens: SecurityTokens)
    func openArrivalTicket(with cityTourData: CityTourModel, tokens: SecurityTokens)
    func openDeparturesTicket(with cityTourData: CityTourModel, tokens: SecurityTokens)
    func openEvents(with cityTourData: CityTourModel, tokens: SecurityTokens)
    func openRestaurants(with cityTourData: CityTourModel, tokens: SecurityTokens)
}

protocol CityTourInfoAssemblyProtocol {
    func createModule(cityTourData: CityTourModel, tokens: SecurityTokens) -> CityTourInfoViewController
}
