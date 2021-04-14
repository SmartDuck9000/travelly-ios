//
//  AuthData.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.03.2021.
//

import UIKit
import RealmSwift

class AuthData: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int
    @objc dynamic var accessToken: String
    @objc dynamic var refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

struct SecurityTokens: Codable {
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
}
