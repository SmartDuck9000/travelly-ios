//
//  KingfisherImageLoader.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.03.2021.
//

import UIKit
import Kingfisher


class KingfisherImageLoader: ImageLoaderProtocol {
    func load(to imageView: UIImageView, from url: String, with cornerRadius: CGFloat, _ placeholder: String?) {
        var placeholderImage: UIImage?
        if let placeholderString = placeholder {
            placeholderImage = UIImage(named: placeholderString)
        } else {
            placeholderImage = UIImage()
        }
        
        let processor = RoundCornerImageProcessor(cornerRadius: cornerRadius)
        
        imageView.kf.setImage(with: URL(string: url),
                              placeholder: placeholderImage,
                              options: [
                                .processor(processor),
                                .scaleFactor(UIScreen.main.scale),
                                .transition(.fade(1))
                              ])
        { (result) in
            switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
