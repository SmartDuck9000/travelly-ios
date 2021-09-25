//
//  RestaurantsFeedData.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

struct RestaurantsData: Codable {
    var restaurantId: Int
    var restaurantName: String
    var rating: Double

    var countryName: String
    var cityName: String
    
    enum CodingKeys: String, CodingKey {
        case restaurantId = "restaurant_id"
        case restaurantName = "restaurant_name"
        case rating

        case countryName = "country_name"
        case cityName = "city_name"
    }
}

struct RestaurantsFilter: Codable {
    var limit: Int
    var offset: Int
    var orderBy: String
    var orderType: String

    var restaurantName: String
    var ratingFrom: Double
    var ratingTo: Double
    var priceFrom: Double
    var priceTo: Double
    var childMenu: Bool
    var smokingRoom: Bool
    var cityName: String
    
    enum CodingKeys: String, CodingKey {
        case limit
        case offset
        case orderBy = "order_by"
        case orderType = "order_type"
        
        case restaurantName = "restaurant_name"
        case ratingFrom = "rating_from"
        case ratingTo = "rating_to"
        case priceFrom = "price_from"
        case priceTo = "price_to"
        case childMenu = "child_menu"
        case smokingRoom = "smoking_room"
        case cityName = "city_name"
    }
}
