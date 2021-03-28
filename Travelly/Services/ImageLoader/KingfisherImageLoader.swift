//
//  KingfisherImageLoader.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.03.2021.
//

import UIKit
import Kingfisher


class KingfisherImageLoader: ImageLoaderProtocol {
    func load(to imageView: UIImageView, from url: String) {
        imageView.kf.setImage(with: URL(string: url))
    }
}
