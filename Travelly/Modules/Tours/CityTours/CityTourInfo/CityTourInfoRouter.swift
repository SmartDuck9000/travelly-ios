//
//  ProfileRouter.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

import UIKit

class CityTourInfoRouter: CityTourInfoRouterProtocol {
    
    private weak var view: CityTourInfoViewController!
    
    init(view: CityTourInfoViewController) {
        self.view = view
    }
    
    func openHotel(with cityTourData: CityTourModel, tokens: SecurityTokens) {
        if cityTourData.hotel_id != 0 {
            let assembly = HotelInfoAssembly()
            let vc = assembly.createModule(with: cityTourData.hotel_id, tokens)
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func openArrivalTicket(with cityTourData: CityTourModel, tokens: SecurityTokens) {
        if cityTourData.ticket_arrival_id != 0 {
            let assembly = TicketInfoAssembly()
            let vc = assembly.createModule(with: cityTourData.ticket_arrival_id, tokens)
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func openDeparturesTicket(with cityTourData: CityTourModel, tokens: SecurityTokens) {
        if cityTourData.ticket_departure_id != 0 {
            let assembly = TicketInfoAssembly()
            let vc = assembly.createModule(with: cityTourData.ticket_departure_id, tokens)
            view.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func openEvents(with cityTourData: CityTourModel, tokens: SecurityTokens) {
        
    }
    
    func openRestaurants(with cityTourData: CityTourModel, tokens: SecurityTokens) {
        
    }
}
