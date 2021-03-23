//
//  ProfileData.swift
//  Travelly
//
//  Created by Георгий Куликов on 22.03.2021.
//

struct ProfileData: Codable {
    var firstName: String
    var lastName: String
    var photoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photoUrl = "photo_url"
    }
}

struct UserIdData {
    var userId: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}
