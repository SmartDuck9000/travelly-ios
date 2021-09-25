//
//  EventInfoViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let topNameLabelSpace: CGFloat = 15
    static let space: CGFloat = 10
}

class EventInfoViewController: UIViewController {
    
    private var presenter: EventInfoPresenterProtocol?
    
    private let eventNameLabel = UILabel()
    private let eventDescriptionLabel = UILabel()
    private let eventAddressLabel = UILabel()
    private let eventDateLabel = UILabel()
    
    private let ratingLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let cityLabel = UILabel()
    private let countryLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadInfo()
    }
    
    func set(presenter: EventInfoPresenterProtocol) {
        self.presenter = presenter
    }

    func setEventName(_ name: String) {
        DispatchQueue.main.async {
            self.eventNameLabel.text = name
        }
    }
    
    func setEventDescription(_ description: String) {
        DispatchQueue.main.async {
            // TODO
        }
    }
    
    func setEventAddress(_ address: String) {
        DispatchQueue.main.async {
            self.eventAddressLabel.text = address
        }
    }
    
    func setEventDate(start: String, end: String) {
        DispatchQueue.main.async {
            self.eventDateLabel.text = "\(start) - \(end)"
        }
    }
    
    func setRating(_ rating: Double) {
        DispatchQueue.main.async {
            self.ratingLabel.text = "Рейтинг: \(rating)"
        }
    }
    
    func setAveragePrice(_ price: String) {
        DispatchQueue.main.async {
            self.priceLabel.text = "Цена: \(price)"
        }
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
        setupEventNameLabel()
        setupEventDescriptionLabel()
        setupEventAddressLabel()
        setupEventDateLabel()
        setupRatingLabel()
        setupPriceLabel()
        setupCityLabel()
        setupCountryLabel()
    }
    
    private func setupEventNameLabel() {
        self.view.addSubview(eventNameLabel)
        let safeArea = self.view.safeAreaLayoutGuide
        
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventNameLabel.topAnchor.constraint(
            equalTo: safeArea.topAnchor,
            constant: LayoutConstants.topNameLabelSpace
        ).isActive = true
        eventNameLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        eventNameLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupEventDescriptionLabel() {
        self.view.addSubview(eventDescriptionLabel)
        eventDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        eventDescriptionLabel.topAnchor.constraint(
            equalTo: eventNameLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        eventDescriptionLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        eventDescriptionLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupEventAddressLabel() {
        self.view.addSubview(eventAddressLabel)
        eventAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        eventAddressLabel.topAnchor.constraint(
            equalTo: eventDescriptionLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        eventAddressLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        eventAddressLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupEventDateLabel() {
        self.view.addSubview(eventDateLabel)
        eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        eventDateLabel.topAnchor.constraint(
            equalTo: eventAddressLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        eventDateLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        eventDateLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupRatingLabel() {
        self.view.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        ratingLabel.topAnchor.constraint(
            equalTo: eventDateLabel.bottomAnchor,
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
    
    private func setupCityLabel() {
        self.view.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        cityLabel.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
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
