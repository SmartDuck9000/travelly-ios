//
//  EventInfoProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import Foundation

protocol EventInfoPresenterProtocol {
    func goBack()
    func loadInfo()
}

protocol EventInfoInteractorProtocol {
    func loadInfo(complition: @escaping (Error?, Bool, EventInfo?) -> Void)
    func deleteAuth()
}

protocol EventInfoRouterProtocol {
    func goBack()
    func openAuth()
}

protocol EventInfoAssemblyProtocol {
    func createModule(with eventId: Int, _ tokens: SecurityTokens) -> EventInfoViewController
}
