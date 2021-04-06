//
//  AuthData.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//

import UIKit

class AuthData: Entity, Codable {
    dynamic var id: Int = 0
    var userId: Int
    var accessToken: String
    var refreshToken: String
    
    init(userId: Int, accessToken: String, refreshToken: String) {
        self.userId = userId
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class SecurityTokens: Entity, Codable {
    dynamic var id: Int = 0
    var accessToken: String
    var refreshToken: String
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
