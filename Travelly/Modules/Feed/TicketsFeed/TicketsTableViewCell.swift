//
//  TicketsTableViewCell.swift
//  Travelly
//
//  Created by Георгий Куликов on 16.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let containerViewHeight: CGFloat = 150
    static let containerViewTopSpace: CGFloat = 5
    static let containerViewBottomSpace: CGFloat = -10
    static let containerViewLeftSpace: CGFloat = 15
    static let containerViewRightSpace: CGFloat = -15
    
    static let topSpace: CGFloat = 10
    static let bottomSpace: CGFloat = -10
    static let leftSpace: CGFloat = 10
    static let rightSpace: CGFloat = -10
    
    static let betweenTopSpace: CGFloat = 10
    static let betweenLeftSpace: CGFloat = 0
    static let betweenRightSpace: CGFloat = 0
    
    static let starsWidth: CGFloat = 15
    static let ratingWidth: CGFloat = 15
    
    static let ratingText = "Рейтинг: "
    static let starImageName = "Star"
    static let starImageSize: CGFloat = 24
}

class TicketsTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let transportTypeLabel = UILabel()
    private let priceLabel = UILabel()
    private let dateLabel = UILabel()
    private let originalCountryCityLabel = UILabel()
    private let destinationCountryCityLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupCell(with data: TicketsData) {
        containerView.frame = CGRect(x: LayoutConstants.containerViewLeftSpace,
                                     y: LayoutConstants.containerViewTopSpace,
                                     width: self.frame.width - LayoutConstants.containerViewLeftSpace * 2,
                                     height: LayoutConstants.containerViewHeight)
        containerView.backgroundColor = FeedCellAppearance.backgroungColor
        containerView.layer.cornerRadius = self.frame.width / 40
        self.addSubview(containerView)

        setupTransportTypeLabel()
        setupPriceLabel()
        setupDateLabel()
        setupOriginalCountryCityLabel()
        setupDestinationCountryCityLabel()
        
        transportTypeLabel.text = "Транспорт: самолет"
        priceLabel.text = "Цена: \(data.price)"
        dateLabel.text = "Дата: \(data.date)"
        originalCountryCityLabel.text = "Место отправления: \(data.origCountryName), \(data.origCityName)"
        destinationCountryCityLabel.text = "Место прибытия: \(data.destCountryName), \(data.destCityName)"
    }
    
    private func setupTransportTypeLabel() {
        containerView.addSubview(transportTypeLabel)
        
        transportTypeLabel.textColor = FeedCellAppearance.textColor
        transportTypeLabel.font = FeedCellAppearance.font
        
        transportTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        transportTypeLabel.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: LayoutConstants.betweenTopSpace
        ).isActive = true
        transportTypeLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: LayoutConstants.leftSpace
        ).isActive = true
        transportTypeLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: LayoutConstants.rightSpace
        ).isActive = true
    }
    
    private func setupPriceLabel() {
        containerView.addSubview(priceLabel)
        
        priceLabel.textColor = FeedCellAppearance.textColor
        priceLabel.font = FeedCellAppearance.font
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(
            equalTo: transportTypeLabel.bottomAnchor,
            constant: LayoutConstants.betweenTopSpace
        ).isActive = true
        priceLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: LayoutConstants.leftSpace
        ).isActive = true
        priceLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: LayoutConstants.rightSpace
        ).isActive = true
    }
    
    private func setupDateLabel() {
        containerView.addSubview(dateLabel)
        
        dateLabel.textColor = FeedCellAppearance.textColor
        dateLabel.font = FeedCellAppearance.font
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: LayoutConstants.betweenTopSpace
        ).isActive = true
        dateLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: LayoutConstants.leftSpace
        ).isActive = true
        dateLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: LayoutConstants.rightSpace
        ).isActive = true
    }
    
    private func setupOriginalCountryCityLabel() {
        containerView.addSubview(originalCountryCityLabel)
        
        originalCountryCityLabel.textColor = FeedCellAppearance.textColor
        originalCountryCityLabel.font = FeedCellAppearance.font
        
        originalCountryCityLabel.translatesAutoresizingMaskIntoConstraints = false
        originalCountryCityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,
                                                  constant: LayoutConstants.betweenTopSpace).isActive = true
        originalCountryCityLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        originalCountryCityLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
    }
    
    private func setupDestinationCountryCityLabel() {
        containerView.addSubview(destinationCountryCityLabel)
        
        destinationCountryCityLabel.textColor = FeedCellAppearance.textColor
        destinationCountryCityLabel.font = FeedCellAppearance.font
        
        destinationCountryCityLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationCountryCityLabel.topAnchor.constraint(equalTo: originalCountryCityLabel.bottomAnchor,
                                                  constant: LayoutConstants.betweenTopSpace).isActive = true
        destinationCountryCityLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        destinationCountryCityLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
    }
}
