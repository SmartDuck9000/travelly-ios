//
//  CityTourInfoDelegate.swift
//  Travelly
//
//  Created by Георгий Куликов on 30.08.2021.
//

import UIKit

protocol CityTourInfoDelegateProtocol {
    var cityTourModel: CityTourModel { get set }
    
    func updateHotel(hotelData: HotelData)
    func updateArrivalTicket(ticketData: TicketsData)
    func updateDepartureTicket(ticketData: TicketsData)
}

class CityTourInfoDelegate: CityTourInfoDelegateProtocol {
    var cityTourModel: CityTourModel
    var postedCityTourData: PostedCityTourModel
    
    private var networkService: NetworkProtocol
    private var dataStorage: DataStorageProtocol
    private var tokens: SecurityTokens
    private weak var view: CityTourInfoViewController?
    
    init(
        cityTourModel: CityTourModel,
        postedCityTourData: PostedCityTourModel,
        networkService: NetworkProtocol,
        dataStorage: DataStorageProtocol,
        tokens: SecurityTokens,
        view: CityTourInfoViewController
    ) {
        self.cityTourModel = cityTourModel
        self.postedCityTourData = postedCityTourData
        self.networkService = networkService
        self.dataStorage = dataStorage
        self.tokens = tokens
        self.view = view
    }
    
    func updateHotel(hotelData: HotelData) {
        cityTourModel.hotel_id = hotelData.hotelId
        postedCityTourData.hotel_id = hotelData.hotelId
        networkService.put(
            query: "0.0.0.0:5001/api/users/city_tours",
            tokens: tokens,
            data: postedCityTourData,
            type: .http
        ) { (_, _, statusCode) in
            if statusCode == 401 {
                self.networkService.refreshToken(query: "0.0.0.0:5002/api/auth", tokens: self.tokens, type: .http) { (data, error, statusCode) in
                    guard let data = data else {
                        self.dataStorage.deleteAuthData()
                        let assembly: AuthAssemblyProtocol = AuthAssembly()
                        let authView: AuthViewController = assembly.createModule()
                        authView.modalPresentationStyle = .fullScreen
                        DispatchQueue.main.async {
                            self.view?.present(authView, animated: false, completion: nil)
                        }
                        return
                    }
                    guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                        self.dataStorage.deleteAuthData()
                        let assembly: AuthAssemblyProtocol = AuthAssembly()
                        let authView: AuthViewController = assembly.createModule()
                        authView.modalPresentationStyle = .fullScreen
                        DispatchQueue.main.async {
                            self.view?.present(authView, animated: false, completion: nil)
                        }
                        return
                    }
                    self.tokens = SecurityTokens(accessToken: authData.accessToken, refreshToken: authData.refreshToken)
                    self.dataStorage.update(authData: authData)
                }
            }
        }
    }
    
    func updateArrivalTicket(ticketData: TicketsData) {
        cityTourModel.ticket_arrival_id = ticketData.ticketId
        postedCityTourData.ticket_arrival_id = ticketData.ticketId
    }
    
    func updateDepartureTicket(ticketData: TicketsData) {
        cityTourModel.ticket_departure_id = ticketData.ticketId
        postedCityTourData.ticket_departure_id = ticketData.ticketId
    }
}
