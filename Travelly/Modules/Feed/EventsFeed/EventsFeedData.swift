//
//  EventsFeedData.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

struct EventsData: Codable {
    var eventId: Int
    var eventName: String
    var eventStart: String
    var eventEnd: String
    var rating: Double
    var maxPersons: Double

    var countryName: String
    var cityName: String
    
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case eventName = "event_name"
        case eventStart = "event_start"
        case eventEnd = "event_end"
        case rating
        case maxPersons = "max_persons"
        
        case countryName = "country_name"
        case cityName = "city_name"
    }
}

struct EventsFilter: Codable {
    var limit: Int
    var offset: Int
    var orderBy: String
    var orderType: String
    
    var eventName: String
    var from: String
    var to: String
    var ratingFrom: Double
    var ratingTo: Double
    var priceFrom: Double
    var priceTo: Double
    var cityName: String
    
    enum CodingKeys: String, CodingKey {
        case limit
        case offset
        case orderBy = "order_by"
        case orderType = "order_type"

        case eventName = "event_name"
        case from
        case to
        case ratingFrom = "rating_from"
        case ratingTo = "rating_to"
        case priceFrom = "price_from"
        case priceTo = "price_to"
        case cityName = "city_name"
    }
}
