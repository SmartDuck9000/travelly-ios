//
//  HotelInfoProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import Foundation

protocol HotelInfoPresenterProtocol {
    func goBack()
    func loadInfo()
}

protocol HotelInfoInteractorProtocol {
    func loadInfo(complition: @escaping (Error?, Bool, HotelInfo?) -> Void)
    func deleteAuth()
}

protocol HotelInfoRouterProtocol {
    func goBack()
    func openAuth()
}

protocol HotelInfoAssemblyProtocol {
    func createModule(with hotelId: Int, _ tokens: SecurityTokens) -> HotelInfoViewController
}
