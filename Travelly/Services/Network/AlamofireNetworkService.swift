//
//  AlamofireNetworkService.swift
//  Travelly
//
//  Created by Георгий Куликов on 25.02.2021.
//

import Alamofire

class AlamofireNetworkService: NetworkProtocol {
    
    func get<Parameters: Encodable>(query: String, tokens: SecurityTokens?, parameters: Parameters, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void) {
        let urlQuery = type.rawValue + query
        let urlEncoder = URLEncodedFormParameterEncoder.default
        var headers: HTTPHeaders?
        
        if let accesToken = tokens?.accessToken {
            headers = getAuthHeaders(token: accesToken)
        }
        
        AF.request(urlQuery, method: .get, parameters: parameters, encoder: urlEncoder, headers: headers).response { (response) in
            complition(response.data, self.getError(response: response), response.response?.statusCode)
        }
    }
    
    func get(query: String, tokens: SecurityTokens?, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void) {
        let urlQuery = type.rawValue + query
        var headers: HTTPHeaders?
        
        if let accesToken = tokens?.accessToken {
            headers = getAuthHeaders(token: accesToken)
        }
        
        AF.request(urlQuery, method: .get, headers: headers).response { (response) in
            complition(response.data, self.getError(response: response), response.response?.statusCode)
        }
    }
    
    
    func post<PostedData: Encodable>(query: String, tokens: SecurityTokens?, data: PostedData, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void) {
        let urlQuery = type.rawValue + query
        let jsonEncoder = JSONParameterEncoder.default
        var headers: HTTPHeaders?
        
        if let accesToken = tokens?.accessToken {
            headers = getAuthHeaders(token: accesToken)
        }
        
        AF.request(urlQuery, method: .post, parameters: data, encoder: jsonEncoder, headers: headers).response { (response) in
            complition(response.data, self.getError(response: response), response.response?.statusCode)
        }
    }
    
    func put<PutData: Encodable>(query: String, tokens: SecurityTokens, data: PutData, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void) {
        let urlQuery = type.rawValue + query
        let jsonEncoder = JSONParameterEncoder.default
        let headers = getAuthHeaders(token: tokens.accessToken)
        
        AF.request(urlQuery, method: .put, parameters: data, encoder: jsonEncoder, headers: headers).response { (response) in
            complition(response.data, self.getError(response: response), response.response?.statusCode)
        }
    }
    
    func refreshToken(query: String, tokens: SecurityTokens, type: ProtocolType, complition: @escaping (Data?, Error?, Int?) -> Void) {
        let urlQuery = type.rawValue + query
        let headers = getAuthHeaders(token: tokens.refreshToken)
        
        AF.request(urlQuery, method: .get, headers: headers).response { (response) in
            complition(response.data, self.getError(response: response), response.response?.statusCode)
        }
    }
    
    private func getError(response: AFDataResponse<Data?>) -> Error? {
        if case let .failure(error) = response.result {
            let error = error as NSError
            return error
        }
        
        return nil
    }
    
    private func getAuthHeaders(token: String) -> HTTPHeaders {
        let headers: HTTPHeaders = [
            .authorization("Bearer \(token)"),
            .accept("application/json")
        ]
        return headers
    }
}
