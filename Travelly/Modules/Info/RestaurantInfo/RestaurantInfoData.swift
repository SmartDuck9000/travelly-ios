//
//  RestaurantInfoData.swift
//  Travelly
//
//  Created by Георгий Куликов on 19.04.2021.
//

import Foundation

struct RestaurantInfoData: Codable {
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}

struct RestaurantInfo: Codable {
    var restaurantId: Int
    
    var restaurantName: String
    var restaurantDescription: String
    var restaurantAddr: String
    
    var averagePrice: Double
    var rating: Double
    
    var childMenu: Bool
    var smokingRoom: Bool
    
    var countryName: String
    var cityName: String
    
    enum CodingKeys: String, CodingKey {
        case restaurantId = "restaurant_id"
        case restaurantName = "restaurant_name"
        case restaurantDescription = "restaurant_description"
        case restaurantAddr = "restaurant_addr"
        case averagePrice = "average_price"
        case rating = "rating"
        case childMenu = "child_menu"
        case smokingRoom = "smoking_room"
        case countryName = "country_name"
        case cityName = "city_name"
    }
}
