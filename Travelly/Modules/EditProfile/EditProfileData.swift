//
//  EditProfileData.swift
//  Travelly
//
//  Created by Георгий Куликов on 03.04.2021.
//

import Foundation

struct EditProfileData: Codable {
    var id: Int
    var email: String
    var oldPassword: String
    var newPassword: String
    var firstName: String
    var lastName: String
    var photoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case oldPassword = "old_password"
        case newPassword = "new_password"
        case photoUrl = "photo_url"
    }
}
