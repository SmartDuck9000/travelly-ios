//
//  AuthProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 16.02.2021.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    func login()
    func register()
}

protocol AuthRouterProtocol: AnyObject {
    func presentLoginWindow()
    func presentRegisterWindow()
}
