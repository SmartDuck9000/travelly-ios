//
//  AuthData.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//

import UIKit

class AuthData: Entity, Codable {
    var accessToken: String
    var refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
