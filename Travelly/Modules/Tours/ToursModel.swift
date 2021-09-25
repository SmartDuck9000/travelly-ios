//
//  ToursModel.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import Foundation

struct ToursModel: Codable {
    let tour_id: Int
    let tour_name: String
    let tour_price: String
    let tour_date_from: String
    let tour_date_to: String
}

struct PostedTourModel: Codable {
    let id: Int
    var user_id: Int
    let tour_name: String
    let tour_price: Double
    let tour_date_from: String
    let tour_date_to: String
}

struct TourIdData: Codable {
    var tour_id: Int
}
