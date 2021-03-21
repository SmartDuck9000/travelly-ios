//
//  NetworkProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 25.02.2021.
//

import Foundation

protocol NetworkProtocol {
    func get<Parameters: Encodable>(query: String, parameters: Parameters, type: ProtocolType, complition: @escaping (Data?, Error?) -> Void)
    func get(query: String, type: ProtocolType, complition: @escaping (Data?, Error?) -> Void)
    
    func post<PostedData: Encodable>(query: String, data: PostedData, type: ProtocolType, complition: @escaping (Data?, Error?) -> Void)
}
