//
//  NetworkConfig.swift
//  Travelly
//
//  Created by Георгий Куликов on 25.02.2021.
//

struct NetworkConfig {
    let host: String = "0.0.0.0"
    let port: String = "5002"
}

enum ProtocolType: String {
    case http = "http://"
    case https = "https://"
}
