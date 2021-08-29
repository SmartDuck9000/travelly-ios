//
//  TicketInfoViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let topNameLabelSpace: CGFloat = 15
}

class TicketInfoViewController: UIViewController {
    
    private var presenter: TicketInfoPresenterProtocol?
    
    private let hotelNameLabel = UILabel()
    private let hotelDescriptionLabel = UILabel()
    private let hotelAddressLabel = UILabel()
    
    private let starsLabel = UILabel()
    private let starImageView = UIImageView()
    
    private let ratingLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let nearSeaLabel = UILabel()
    private let nearSeaImageView = UIImageView()
    
    private let cityLabel = UILabel()
    private let countryLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadInfo()
    }
    
    func set(presenter: TicketInfoPresenterProtocol) {
        self.presenter = presenter
    }

    func setHotelName(_ name: String) {
        DispatchQueue.main.async {
            self.hotelNameLabel.text = name
        }
    }
    
    func setHotelDescription(_ description: String) {
        DispatchQueue.main.async {
            // TODO
        }
    }
    
    func setHotelAddress(_ address: String) {
        DispatchQueue.main.async {
            self.hotelAddressLabel.text = address
        }
    }
    
    func setStars(_ stars: Int) {
        DispatchQueue.main.async {
            self.starsLabel.text = "\(stars)"
        }
    }
    
    func setHotelRating(_ rating: Double) {
        DispatchQueue.main.async {
            self.ratingLabel.text = "Рейтинг: \(rating)"
        }
    }
    
    func setAveragePrice(_ price: Double) {
        DispatchQueue.main.async {
            self.priceLabel.text = "Средняя цена: \(price) $"
        }
    }
    
    func setNearSea(_ nearSea: Bool) {
        // TODO
    }
    
    func setCountryName(_ country: String) {
        DispatchQueue.main.async {
            self.countryLabel.text = "\(country)"
        }
    }
    
    func setCityName(_ city: String) {
        DispatchQueue.main.async {
            self.cityLabel.text = "\(city)"
        }
    }
    
    private func setupView() {
        setupHotelNameLabel()
    }
    
    private func setupHotelNameLabel() {
        self.view.addSubview(hotelNameLabel)
        let safeArea = self.view.safeAreaLayoutGuide
        
        hotelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        hotelNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: LayoutConstants.topNameLabelSpace).isActive = true
        
        
    }
}
