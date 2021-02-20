//
//  RegisterAssembly.swift
//  Travelly
//
//  Created by Георгий Куликов on 21.02.2021.
//

import UIKit

class RegisterAssembly: RegisterAssemblyProtocol, DependencyRegistratorProtocol {
    func registerDependencies() {
        
    }
    
    func createModule() -> RegisterViewController {
        return RegisterViewController()
    }
}
