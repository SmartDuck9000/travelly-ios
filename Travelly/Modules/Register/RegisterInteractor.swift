//
//  RegisterInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.02.2021.
//

import Foundation

class RegisterInteractor: RegisterInteractorProtocol {
    
    private let networkService: NetworkProtocol
    
    init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    func registerUser(email: String, firstName: String, lastName: String) {
        let registerData = RegisterData(email: email, firstName: firstName, lastName: lastName)
        networkService.post(query: "/api/auth/email_register", data: registerData, type: .https)
    }
}
