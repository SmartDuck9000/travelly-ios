//
//  AuthData.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//

import UIKit

class AuthData: Codable {
    var userId: Int
    var accessToken: String
    var refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

class SecurityTokens: Entity {
    var accessToken: String
    var refreshToken: String
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
