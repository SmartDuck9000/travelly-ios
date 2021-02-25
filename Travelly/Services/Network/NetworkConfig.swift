//
//  NetworkConfig.swift
//  Travelly
//
//  Created by Георгий Куликов on 25.02.2021.
//

struct NetworkConfig {
    let host: String = ""
    let port: String = ""
}

enum ProtocolType: String {
    case http = "http://"
    case https = "https://"
}
