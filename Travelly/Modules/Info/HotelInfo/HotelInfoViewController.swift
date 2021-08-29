//
//  HotelInfoViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let topNameLabelSpace: CGFloat = 15
    static let leftNameLabelSpace: CGFloat = 10
    static let rightNameLabelSpace: CGFloat = 10
    static let space: CGFloat = 10
}

class HotelInfoViewController: UIViewController {
    
    private var presenter: HotelInfoPresenterProtocol?
    
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
    
    func set(presenter: HotelInfoPresenterProtocol) {
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
            self.hotelAddressLabel.text = "Адрес: \(address)"
        }
    }
    
    func setStars(_ stars: Int) {
        DispatchQueue.main.async {
            self.starsLabel.text = "Звезд: \(stars)"
        }
    }
    
    func setHotelRating(_ rating: Double) {
        DispatchQueue.main.async {
            self.ratingLabel.text = "Рейтинг: \(rating)"
        }
    }
    
    func setAveragePrice(_ price: String) {
        DispatchQueue.main.async {
            self.priceLabel.text = "Средняя цена: \(price)"
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
        self.view.backgroundColor = .white
        setupHotelNameLabel()
        setupHotelDescriptionLabel()
        setupHotelAddressLabel()
        setupStarsLabel()
        setupStarImageView()
        setupRatingLabel()
        setupPriceLabel()
        setupNearSeaLabel()
        setupNearSeaImageView()
        setupCityLabel()
        setupCountryLabel()
    }
    
    private func setupHotelNameLabel() {
        self.view.addSubview(hotelNameLabel)
        let safeArea = self.view.safeAreaLayoutGuide
        
        hotelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        hotelNameLabel.topAnchor.constraint(
            equalTo: safeArea.topAnchor,
            constant: LayoutConstants.topNameLabelSpace
        ).isActive = true
        hotelNameLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        hotelNameLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupHotelDescriptionLabel() {
        self.view.addSubview(hotelDescriptionLabel)
        hotelDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        hotelDescriptionLabel.topAnchor.constraint(
            equalTo: hotelNameLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        hotelDescriptionLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        hotelDescriptionLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupHotelAddressLabel() {
        self.view.addSubview(hotelAddressLabel)
        hotelAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        hotelAddressLabel.topAnchor.constraint(
            equalTo: hotelDescriptionLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        hotelAddressLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        hotelAddressLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupStarsLabel() {
        self.view.addSubview(starsLabel)
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        starsLabel.topAnchor.constraint(
            equalTo: hotelAddressLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        starsLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupStarImageView() {
        self.view.addSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        
        starImageView.topAnchor.constraint(
            equalTo: hotelAddressLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        starImageView.leftAnchor.constraint(
            equalTo: starsLabel.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupRatingLabel() {
        self.view.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        ratingLabel.topAnchor.constraint(
            equalTo: starsLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        ratingLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        ratingLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupPriceLabel() {
        self.view.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        priceLabel.topAnchor.constraint(
            equalTo: ratingLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        priceLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        priceLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupNearSeaLabel() {
        self.view.addSubview(nearSeaLabel)
        nearSeaLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        nearSeaLabel.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        nearSeaLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupNearSeaImageView() {
        self.view.addSubview(nearSeaImageView)
        nearSeaImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nearSeaImageView.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        nearSeaImageView.leftAnchor.constraint(
            equalTo: nearSeaLabel.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupCityLabel() {
        self.view.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        cityLabel.topAnchor.constraint(
            equalTo: nearSeaLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        cityLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        cityLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupCountryLabel() {
        self.view.addSubview(countryLabel)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        countryLabel.topAnchor.constraint(
            equalTo: cityLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        countryLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        countryLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
}
