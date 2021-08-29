//
//  RestaurantInfoViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let topNameLabelSpace: CGFloat = 15
    static let space: CGFloat = 10
}

class RestaurantInfoViewController: UIViewController {
    
    private var presenter: RestaurantInfoPresenterProtocol?
    
    private let restaurantNameLabel = UILabel()
    private let restaurantDescriptionLabel = UILabel()
    private let restaurantAddressLabel = UILabel()
    
    private let ratingLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let childMenuLabel = UILabel()
    private let childMenuImageView = UIImageView()
    
    private let smokingRoomLabel = UILabel()
    private let smokingRoomImageView = UIImageView()
    
    private let cityLabel = UILabel()
    private let countryLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadInfo()
    }
    
    func set(presenter: RestaurantInfoPresenterProtocol) {
        self.presenter = presenter
    }

    func setRestaurantName(_ name: String) {
        DispatchQueue.main.async {
            self.restaurantNameLabel.text = name
        }
    }
    
    func setRestaurantDescription(_ description: String) {
        DispatchQueue.main.async {
            // TODO
        }
    }
    
    func setRestaurantAddress(_ address: String) {
        DispatchQueue.main.async {
            self.restaurantAddressLabel.text = "Адрес: \(address)"
        }
    }
    
    func setRating(_ rating: Double) {
        DispatchQueue.main.async {
            self.ratingLabel.text = "Рейтинг: \(rating)"
        }
    }
    
    func setAveragePrice(_ price: Double) {
        DispatchQueue.main.async {
            self.priceLabel.text = "Средняя цена: \(price) $"
        }
    }
    
    func setChildMenu(_ nearSea: Bool) {
        // TODO
    }
    
    func setSmokingRoom(_ nearSea: Bool) {
        // TODO
    }
    
    func setCountryName(_ country: String) {
        DispatchQueue.main.async {
            self.countryLabel.text = "Страна: \(country)"
        }
    }
    
    func setCityName(_ city: String) {
        DispatchQueue.main.async {
            self.cityLabel.text = "Город: \(city)"
        }
    }
    
    
    private func setupView() {
        self.view.backgroundColor = .white
        setupRestaurantNameLabel()
        setupRestaurantDescriptionLabel()
        setupRestaurantAddressLabel()
        setupRatingLabel()
        setupPriceLabel()
        setupChildMenuLabel()
        setupChildMenuImageView()
        setupSmokingRoomLabel()
        setupSmokingRoomImageView()
        setupCityLabel()
        setupCountryLabel()
    }
    
    private func setupRestaurantNameLabel() {
        self.view.addSubview(restaurantNameLabel)
        let safeArea = self.view.safeAreaLayoutGuide
        
        restaurantNameLabel.translatesAutoresizingMaskIntoConstraints = false
        restaurantNameLabel.topAnchor.constraint(
            equalTo: safeArea.topAnchor,
            constant: LayoutConstants.topNameLabelSpace
        ).isActive = true
        restaurantNameLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        restaurantNameLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupRestaurantDescriptionLabel() {
        self.view.addSubview(restaurantDescriptionLabel)
        restaurantDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        restaurantDescriptionLabel.topAnchor.constraint(
            equalTo: restaurantNameLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        restaurantDescriptionLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        restaurantDescriptionLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupRestaurantAddressLabel() {
        self.view.addSubview(restaurantAddressLabel)
        restaurantAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        restaurantAddressLabel.topAnchor.constraint(
            equalTo: restaurantDescriptionLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        restaurantAddressLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        restaurantAddressLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupRatingLabel() {
        self.view.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        ratingLabel.topAnchor.constraint(
            equalTo: restaurantAddressLabel.bottomAnchor,
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
    
    private func setupChildMenuLabel() {
        self.view.addSubview(childMenuLabel)
        childMenuLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        childMenuLabel.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        childMenuLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupChildMenuImageView() {
        self.view.addSubview(childMenuImageView)
        childMenuImageView.translatesAutoresizingMaskIntoConstraints = false
        
        childMenuImageView.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        childMenuImageView.leftAnchor.constraint(
            equalTo: childMenuLabel.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupSmokingRoomLabel() {
        self.view.addSubview(smokingRoomLabel)
        smokingRoomLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        smokingRoomLabel.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        smokingRoomLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupSmokingRoomImageView() {
        self.view.addSubview(smokingRoomImageView)
        smokingRoomImageView.translatesAutoresizingMaskIntoConstraints = false
        
        smokingRoomImageView.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        smokingRoomImageView.leftAnchor.constraint(
            equalTo: smokingRoomLabel.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupCityLabel() {
        self.view.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        cityLabel.topAnchor.constraint(
            equalTo: smokingRoomLabel.bottomAnchor,
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
