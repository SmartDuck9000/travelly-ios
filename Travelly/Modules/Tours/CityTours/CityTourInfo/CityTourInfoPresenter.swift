//
//  ProfilePresenter.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class CityTourInfoPresenter: CityTourInfoPresenterProtocol {
    
    weak var view: CityTourInfoViewController!
    private var optionsInteractor: CityTourInfoOptionsInteractorProtocol
    private var router: CityTourInfoRouterProtocol
    
    private var tokens: SecurityTokens
    private(set) var cityTourData: CityTourModel
    
    init(
        view: CityTourInfoViewController,
        router: CityTourInfoRouterProtocol,
        optionsInteractor: CityTourInfoOptionsInteractorProtocol,
        tokens: SecurityTokens,
        cityTourData: CityTourModel
    ) {
        self.view = view
        self.optionsInteractor = optionsInteractor
        self.router = router
        self.tokens = tokens
        self.cityTourData = cityTourData
    }
    
    func optionsCount() -> Int {
        return optionsInteractor.optionsCount()
    }
    
    func configureOptionCell(_ cell: CityTourInfoOptionTableViewCell, at index: Int) {
        guard let optionData = optionsInteractor.getCityTourInfoOptionData(at: index) else { return }
        cell.setOptionName(optionData.name)
        cell.setupCell()
        
        switch index {
        case 0:
            cell.setImage(UIImage(named: "HotelImage"))
        case 1:
            cell.setImage(UIImage(named: "TicketImage"))
        case 2:
            cell.setImage(UIImage(named: "TicketImage"))
        case 3:
            cell.setImage(UIImage(named: "EventImage"))
        case 4:
            cell.setImage(UIImage(named: "RestaurantImage"))
        default:
            print("No option at index: \(index)")
        }
    }
    
    func selectOption(at index: Int) {
        switch index {
        case 0:
            router.openHotel(with: cityTourData, tokens: tokens)
        case 1:
            router.openArrivalTicket(with: cityTourData, tokens: tokens)
        case 2:
            router.openDeparturesTicket(with: cityTourData, tokens: tokens)
        case 3:
            router.openEvents(with: cityTourData, tokens: tokens)
        case 4:
            router.openRestaurants(with: cityTourData, tokens: tokens)
        default:
            print("No option at index: \(index)")
        }
    }
}
