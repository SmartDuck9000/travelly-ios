//
//  CityToursModel.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import Foundation

struct CityTourModel: Codable {
    var city_tour_id: Int
    var country_name: String
    var city_name: String
    var city_tour_price: String
    var date_from: String
    var date_to: String
    var ticket_arrival_id: Int
    var ticket_departure_id: Int
    var hotel_id: Int
}

struct PostedCityTourModel: Codable {
    var id: Int
    var tour_id: Int
    var city_id: Int
    var city_tour_price: Double
    var date_from: String
    var date_to: String
    var ticket_arrival_id: Int
    var ticket_departure_id: Int
    var hotel_id: Int
}

struct CityData: Codable {
    var city_id: Int
    var city_name: String
}

struct CityTourIdData: Codable {
    var city_tour_id: Int
}
