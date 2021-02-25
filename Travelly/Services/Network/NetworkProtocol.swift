//
//  NetworkProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 25.02.2021.
//

import Foundation

protocol NetworkProtocol {
    func get<Parameters: Encodable>(query: String, parameters: Parameters, type: ProtocolType) -> Data?
    func get(query: String, type: ProtocolType) -> Data?
    
    func post<PostedData: Encodable>(query: String, data: PostedData, type: ProtocolType)
}
