//
//  HotelFeedProtocols.swift
//  Travelly
//
//  Created by Георгий Куликов on 15.04.2021.
//

import Foundation

protocol HotelFeedPresenterProtocol {
    
}

protocol HotelFeedInteractorProtocol {
    
}

protocol HotelFeedRouterProtocol {
    func goBack()
    func openFullInfo(with id: Int, _ tokens: SecurityTokens)
}

protocol HotelFeedAssemblyProtocol {
    func createModule(with userId: Int, _ tokens: SecurityTokens) -> HotelFeedViewController
}
