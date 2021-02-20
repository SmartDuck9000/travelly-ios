//
//  AuthAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 16.02.2021.
//

import Foundation

class AuthAssembly: AuthAssemblyProtocol {
    func createModule() -> AuthViewController {
        return AuthViewController()
    }
}
