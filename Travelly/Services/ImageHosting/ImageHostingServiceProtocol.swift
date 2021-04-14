//
//  ImageHostingServiceProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 14.04.2021.
//

import UIKit

protocol ImageHostingServiceProtocol {
    func getUrl(for image: UIImage) -> String
}
