//
//  NetworkProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 25.02.2021.
//

import Foundation

protocol NetworkProtocol {
    func get<Parameters: Encodable>(query: String, tokens: SecurityTokens?, parameters: Parameters, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void)
    func get(query: String, tokens: SecurityTokens?, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void)
    
    func post<PostedData: Encodable>(query: String, tokens: SecurityTokens?, data: PostedData, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void)
    
    func put<PutData: Encodable>(query: String, tokens: SecurityTokens, data: PutData, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void)
    
    func refreshToken(query: String, tokens: SecurityTokens, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void)
}
