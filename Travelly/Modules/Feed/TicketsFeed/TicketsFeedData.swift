//
//  TicketsFeedData.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

struct TicketsData: Codable {
    var ticketId: Int
    var transportType: String
    var price: String
    var date: String

    var origCountryName: String
    var origCityName: String
    var destCountryName: String
    var destCityName: String
    
    enum CodingKeys: String, CodingKey {
        case ticketId = "ticket_id"
        case transportType = "transport_type"
        case price
        case date

        case origCountryName = "orig_country_name"
        case origCityName = "orig_city_name"
        case destCountryName = "dest_country_name"
        case destCityName = "dest_city_name"
    }
}

struct TicketsFilter: Codable {
    var limit: Int
    var offset: Int
    var orderBy: String
    var orderType: String

    var transportType: String
    var dateFrom: String
    var dateTo: String
    var priceFrom: Double
    var priceTo: Double

    var origCityName: String
    var destCityName: String
    
    enum CodingKeys: String, CodingKey {
        case limit
        case offset
        case orderBy = "order_by"
        case orderType = "order_type"

        case transportType = "transport_type"
        case dateFrom = "date_from"
        case dateTo = "date_to"
        case priceFrom = "price_from"
        case priceTo = "price_to"

        case origCityName = "orig_city_name"
        case destCityName = "dest_city_name"
    }
}
