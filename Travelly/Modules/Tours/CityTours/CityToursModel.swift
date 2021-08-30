//
//  CityToursModel.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import Foundation

class CityTourModel: Codable {
    var city_tour_id: Int
    var country_name: String
    var city_id: Int
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
    
    init(
        id: Int,
        tour_id: Int,
        city_id: Int,
        city_tour_price: Double,
        date_from: String,
        date_to: String,
        ticket_arrival_id: Int,
        ticket_departure_id: Int,
        hotel_id: Int
    ) {
        self.id = id
        self.tour_id = tour_id
        self.city_id = city_id
        self.city_tour_price = city_tour_price
        self.date_from = date_from
        self.date_to = date_to
        self.ticket_arrival_id = ticket_arrival_id
        self.ticket_departure_id = ticket_departure_id
        self.hotel_id = hotel_id
    }
    
    init(from cityTourModel: CityTourModel, tourId: Int) {
        self.id = cityTourModel.city_tour_id
        self.tour_id = tourId
        self.city_id = cityTourModel.city_id
        var city_tour_price = cityTourModel.city_tour_price
        city_tour_price.removeFirst()
        self.city_tour_price = Double(city_tour_price) ?? 0.0
        self.date_from = cityTourModel.date_from
        self.date_to = cityTourModel.date_to
        self.ticket_arrival_id = cityTourModel.ticket_arrival_id
        self.ticket_departure_id = cityTourModel.ticket_departure_id
        self.hotel_id = cityTourModel.hotel_id
    }
}

struct CityData: Codable {
    var city_id: Int
    var city_name: String
}

struct CityTourIdData: Codable {
    var city_tour_id: Int
}
