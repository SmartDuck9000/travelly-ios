//
//  AlamofireNetworkService.swift
//  Travelly
//
//  Created by Георгий Куликов on 25.02.2021.
//

import Alamofire

class AlamofireNetworkService: NetworkProtocol {
    let config = NetworkConfig()
    
    func get<Parameters: Encodable>(query: String, parameters: Parameters, type: ProtocolType) -> Data? {
        let urlQuery = type.rawValue + config.host + ":" + config.port + query
        AF.request(urlQuery,
                   method: .get,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder.default).response { (response) in
            debugPrint(response)
        }
        
        return nil
    }
    
    func get(query: String, type: ProtocolType) -> Data? {
        let urlQuery = type.rawValue + config.host + ":" + config.port + query
        AF.request(urlQuery, method: .get).response { (response) in
            debugPrint(response)
        }
        
        return nil
    }
    
    
    func post<PostedData: Encodable>(query: String, data: PostedData, type: ProtocolType) {
        let urlQuery = type.rawValue + config.host + ":" + config.port + query
        
        AF.request(urlQuery,
                   method: .post,
                   parameters: data,
                   encoder: JSONParameterEncoder.default).response { (response) in
            debugPrint(response)
        }
    }
}
