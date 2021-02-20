//
//  RegisterData.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.02.2021.
//

struct RegisterData: Encodable {
    let email: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
