//
//  CloudinaryImageHostingService.swift
//  Travelly
//
//  Created by Георгий Куликов on 14.04.2021.
//

import UIKit
import Cloudinary

fileprivate struct HostingConfig {
    static let cloudName = "dmm1eczvq"
    static let apiKey = "322187316548621"
    static let apiSecret = "HETuLEBoJCJ70tt_zDQ_hdC_dJA"
}

class CloudinaryImageHostingService: ImageHostingServiceProtocol {
    
    private let cloudinary: CLDCloudinary
    
    init() {
        let config = CLDConfiguration(cloudName: HostingConfig.cloudName,
                                      apiKey: HostingConfig.apiKey,
                                      apiSecret: HostingConfig.apiSecret)
        self.cloudinary = CLDCloudinary(configuration: config)
    }
    
    func getUrl(for image: UIImage, complition: @escaping (String?) -> Void) {
        guard let imageData = image.pngData() else { return }
        cloudinary.createUploader().signedUpload(data: imageData, completionHandler:  { (result, error) in
            if let err = error {
                print(err.localizedDescription)
                complition(nil)
            }
            
            complition(result?.url)
        })
    }
}
