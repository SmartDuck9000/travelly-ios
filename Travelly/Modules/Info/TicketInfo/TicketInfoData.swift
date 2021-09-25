//
//  TicketInfoData.swift
//  Travelly
//
//  Created by Георгий Куликов on 19.04.2021.
//

import Foundation

struct TicketInfoData: Codable {
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}

struct TicketInfo: Codable {
    var ticket_id: Int

    var company_name: String
    var company_rating: Double

    var orig_station_name: String
    var orig_station_addr: String
    var orig_country_name: String
    var orig_city_name: String

    var dest_station_name: String
    var dest_station_addr: String
    var dest_city_name: String
    var dest_country_name: String

    var transport_type: String
    var price: String
    var ticket_date: String
    
    enum CodingKeys: String, CodingKey {
        case ticket_id

        case company_name
        case company_rating

        case orig_station_name
        case orig_station_addr
        case orig_country_name
        case orig_city_name

        case dest_station_name
        case dest_station_addr
        case dest_city_name
        case dest_country_name

        case transport_type
        case price
        case ticket_date
    }
}
