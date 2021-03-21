//
//  AlamofireNetworkService.swift
//  Travelly
//
//  Created by Георгий Куликов on 25.02.2021.
//

import Alamofire

class AlamofireNetworkService: NetworkProtocol {
    let config = NetworkConfig()
    
    func get<Parameters: Encodable>(query: String, parameters: Parameters, type: ProtocolType, complition: @escaping (Data?, Error?) -> Void) {
        let urlQuery = type.rawValue + config.host + ":" + config.port + query
        let urlEncoder = URLEncodedFormParameterEncoder.default
        
        AF.request(urlQuery, method: .get, parameters: parameters, encoder: urlEncoder).response { (response) in
            complition(response.data, self.getError(response: response))
        }
    }
    
    func get(query: String, type: ProtocolType, complition: @escaping (Data?, Error?) -> Void) {
        let urlQuery = type.rawValue + config.host + ":" + config.port + query
        AF.request(urlQuery, method: .get).response { (response) in
            complition(response.data, self.getError(response: response))
        }
    }
    
    
    func post<PostedData: Encodable>(query: String, data: PostedData, type: ProtocolType, complition: @escaping (Data?, Error?) -> Void) {
        let urlQuery = type.rawValue + config.host + ":" + config.port + query
        let jsonEncoder = JSONParameterEncoder.default
        
        AF.request(urlQuery, method: .post, parameters: data, encoder: jsonEncoder).response { (response) in
            complition(response.data, self.getError(response: response))
        }
    }
    
    private func getError(response: AFDataResponse<Data?>) -> Error? {
        if case let .failure(error) = response.result {
            let error = error as NSError
            return error
        }
        
        return nil
    }
}
