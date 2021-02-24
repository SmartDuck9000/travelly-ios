//
//  NetworkProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 25.02.2021.
//

import Foundation

protocol NetworkProtocol {
    func get(query: String) -> Data?
    func post(query: String, data: Data?)
}
