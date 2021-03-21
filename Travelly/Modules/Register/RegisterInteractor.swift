//
//  RegisterInteractor.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.02.2021.
//

import Foundation

class RegisterInteractor: RegisterInteractorProtocol {
    
    private weak var presenter: RegisterPresenterProtocol?
    private let networkService: NetworkProtocol
    private let dataStorageService: DataStorageProtocol
    
    init(networkService: NetworkProtocol, dataStorageService: DataStorageProtocol) {
        self.networkService = networkService
        self.dataStorageService = dataStorageService
    }
    
    func registerUser(email: String, password: String, firstName: String, lastName: String) {
        let registerData = RegisterData(email: email, password: password, firstName: firstName, lastName: lastName)
        networkService.post(query: "/api/auth/email_register", data: registerData, type: .http) { (data, error) in
            guard let data = data else {
                self.presenter?.showAuthError(message: "")
                return
            }
            
            if let _ = error {
                self.presenter?.showAuthError(message: "")
            } else {
                guard let authData = try? JSONDecoder().decode(AuthData.self, from: data) else {
                    self.presenter?.showAuthError(message: "")
                    return
                }
                self.dataStorageService.save(dataModel: authData)
                self.presenter?.openProfile()
            }
        }
    }
    
    func setPresenter(_ presenter: RegisterPresenterProtocol) {
        self.presenter = presenter
    }
}
