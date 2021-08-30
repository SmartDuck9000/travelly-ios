//
//  TicketInfoViewController.swift
//  Travelly
//
//  Created by Георгий Куликов on 18.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let topNameLabelSpace: CGFloat = 15
    static let space: CGFloat = 10
}

class TicketInfoViewController: UIViewController {
    
    private var presenter: TicketInfoPresenterProtocol?
    
    private var companyNameLabel = UILabel()
    private var companyRatingLabel = UILabel()
    private var originalStationAddrLabel = UILabel()
    private var destinationStationAddrLabel = UILabel()

    private var transportTypeLabel = UILabel()
    
    private var priceLabel = UILabel()
    private var ticketDateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.loadInfo()
    }
    
    func set(presenter: TicketInfoPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(with data: TicketInfo) {
        companyNameLabel.text = "Транспортная компания: \(data.company_name)"
        companyRatingLabel.text = "Рейтинг компании: \(data.company_rating)"
        originalStationAddrLabel.text = "Место отправления: \(data.orig_station_name)"
        destinationStationAddrLabel.text = "Место прибытия: \(data.dest_station_name)"
        
        transportTypeLabel.text = "Тип транспорта: самолет"
        priceLabel.text = "Цена: \(data.price)"
        ticketDateLabel.text = "Дата отправления: \(data.ticket_date)"
    }

    private func setupView() {
        self.view.backgroundColor = .white
        setupCompanyNameLabel()
        setupCompanyRatingLabel()
        setupOriginalStationAddrLabel()
        setupDestinationStationAddrLabel()
        setupTransportTypeLabel()
        setupPriceLabel()
        setupTicketDateLabel()
    }
    
    private func setupCompanyNameLabel() {
        self.view.addSubview(companyNameLabel)
        let safeArea = self.view.safeAreaLayoutGuide
        
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.topAnchor.constraint(
            equalTo: safeArea.topAnchor,
            constant: LayoutConstants.topNameLabelSpace
        ).isActive = true
        companyNameLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        companyNameLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupCompanyRatingLabel() {
        self.view.addSubview(companyRatingLabel)
        companyRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        companyRatingLabel.topAnchor.constraint(
            equalTo: companyNameLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        companyRatingLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        companyRatingLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupOriginalStationAddrLabel() {
        self.view.addSubview(originalStationAddrLabel)
        originalStationAddrLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        originalStationAddrLabel.topAnchor.constraint(
            equalTo: companyRatingLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        originalStationAddrLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        originalStationAddrLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupDestinationStationAddrLabel() {
        self.view.addSubview(destinationStationAddrLabel)
        destinationStationAddrLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        destinationStationAddrLabel.topAnchor.constraint(
            equalTo: originalStationAddrLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        destinationStationAddrLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        destinationStationAddrLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupTransportTypeLabel() {
        self.view.addSubview(transportTypeLabel)
        transportTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        transportTypeLabel.topAnchor.constraint(
            equalTo: destinationStationAddrLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        transportTypeLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        transportTypeLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
    
    private func setupPriceLabel() {
        self.view.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        priceLabel.topAnchor.constraint(
            equalTo: transportTypeLabel.bottomAnchor,
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
    
    private func setupTicketDateLabel() {
        self.view.addSubview(ticketDateLabel)
        ticketDateLabel.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = self.view.safeAreaLayoutGuide
        
        ticketDateLabel.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        ticketDateLabel.leftAnchor.constraint(
            equalTo: safeArea.leftAnchor,
            constant: LayoutConstants.space
        ).isActive = true
        ticketDateLabel.rightAnchor.constraint(
            equalTo: safeArea.rightAnchor,
            constant: LayoutConstants.space
        ).isActive = true
    }
}
