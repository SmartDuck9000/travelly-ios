//
//  HotelFeedData.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

struct HotelData: Codable {
    var hotelId: Int
    var hotelName: String
    var stars: Int
    var hotelRating: Double

    var countryName: String
    var cityName: String
    
    enum CodingKeys: String, CodingKey {
        case hotelId = "hotel_id"
        case hotelName = "hotel_name"
        case stars
        case hotelRating = "hotel_rating"

        case countryName = "country_name"
        case cityName = "city_name"
    }
}

struct HotelFilter: Codable {
    var limit: Int
    var offset: Int
    var orderBy: String
    var orderType: String

    var hotelName: String
    var starsFrom: Int
    var starsTo: Int
    var ratingFrom: Double
    var ratingTo: Double
    var priceFrom: Double
    var priceTo: Double

    var nearSea: Bool
    var cityName: String
    
    enum CodingKeys: String, CodingKey {
        case limit
        case offset
        case orderBy = "order_by"
        case orderType = "order_type"

        case hotelName = "hotel_name"
        case starsFrom = "stars_from"
        case starsTo = "stars_to"
        case ratingFrom = "rating_from"
        case ratingTo = "rating_to"
        case priceFrom = "price_from"
        case priceTo = "price_to"

        case nearSea = "near_sea"
        case cityName = "city_name"
    }
}
