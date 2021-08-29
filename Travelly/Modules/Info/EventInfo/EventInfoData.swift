//
//  EventInfoData.swift
//  Travelly
//
//  Created by Георгий Куликов on 19.04.2021.
//

import Foundation

struct EventInfoData: Codable {
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}

struct EventInfo: Codable {
    var eventId: Int
    var eventName: String
    var eventDescription: String
    var eventAddr: String
    
    var countryName: String
    var cityName: String
    
    var eventStart: String
    var eventEnd: String
    var price: Double
    var rating: Double
    
    var maxPersons: Int
    var curPersons: Int
    var languages: [String]
    
    enum CodingKeys: String, CodingKey {
        case eventId = "event_id"
        case eventName = "event_name"
        case eventDescription = "event_description"
        case eventAddr = "event_addr"
        
        case countryName = "country_name"
        case cityName = "city_name"
        
        case eventStart = "event_start"
        case eventEnd = "event_end"
        case price
        case rating
        
        case maxPersons = "max_persons"
        case curPersons = "cur_persons"
        case languages
    }
}
