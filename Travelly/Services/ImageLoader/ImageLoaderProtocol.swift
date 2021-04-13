//
//  ImageLoaderProtocol.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.03.2021.
//

import UIKit

protocol ImageLoaderProtocol {
    func load(to imageView: UIImageView, from url: String, with cornerRadius: CGFloat, _ placeholder: String?)
}
