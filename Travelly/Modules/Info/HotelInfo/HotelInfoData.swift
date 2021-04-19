//
//  HotelInfoData.swift
//  Travelly
//
//  Created by Георгий Куликов on 19.04.2021.
//

import Foundation

struct HotelInfoData: Codable {
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
    }
}

struct HotelInfo: Codable {
    var hotelId: Int
    var hotelName: String
    var hotelDescription: String
    var hotelAddr: String

    var stars: Int
    var hotelRating: Double
    var averagePrice: Double

    var nearSea: Bool

    var countryName: String
    var cityName: String
    
    enum CodingKeys: String, CodingKey {
        case hotelId = "hotel_id"
        case hotelName = "hotel_name"
        case hotelDescription = "hotel_description"
        case hotelAddr = "hotel_addr"
        case stars
        case hotelRating = "hotel_rating"
        case averagePrice = "average_price"
        case nearSea = "near_sea"
        case countryName = "country_name"
        case cityName = "city_name"
    }
}
