//
//  HotelTableViewCell.swift
//  Travelly
//
//  Created by Георгий Куликов on 16.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let containerViewHeight: CGFloat = 130
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

class EventsTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let eventNameLabel = UILabel()
    private let eventStartLabel = UILabel()
    private let eventEndLabel = UILabel()
    private let ratingLabel = UILabel()
    private let maxPersonsLabel = UILabel()
    
    private let countryCityNameLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setEventName(_ eventName: String) {
        self.eventNameLabel.text = eventName
    }
    
    func setEventStartLabel(_ start: String) {
        self.eventStartLabel.text = "Начало: \(start)"
    }
    
    func setEventEndLabel(_ end: String) {
        self.eventEndLabel.text = "Конец: \(end)"
    }
    
    func setRating(_ rating: Double) {
        self.ratingLabel.text = LayoutConstants.ratingText + "\(rating)"
    }
    
    func setMaxPersons(_ maxPersons: Int) {
        self.maxPersonsLabel.text = "Максимальное число людей: \(maxPersons)"
    }
    
    func setCountryCityName(_ countryName: String, cityName: String) {
        self.countryCityNameLabel.text = countryName + ", " + cityName
    }
    
    func setupCell() {
        containerView.frame = CGRect(x: LayoutConstants.containerViewLeftSpace,
                                     y: LayoutConstants.containerViewTopSpace,
                                     width: self.frame.width - LayoutConstants.containerViewLeftSpace * 2,
                                     height: LayoutConstants.containerViewHeight)
        containerView.backgroundColor = FeedCellAppearance.backgroungColor
        containerView.layer.cornerRadius = self.frame.width / 40
        self.addSubview(containerView)

        setupEventNameLabel()
        setupStart()
        setupEnd()
        setupCountryCityNameLabel()
        setupRatingLabel()
    }
    
    private func setupEventNameLabel() {
        containerView.addSubview(eventNameLabel)
        
        eventNameLabel.textColor = FeedCellAppearance.textColor
        eventNameLabel.font = FeedCellAppearance.boldFont
        
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        eventNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        eventNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
    }
    
    private func setupStart() {
        containerView.addSubview(eventStartLabel)
        
        eventStartLabel.translatesAutoresizingMaskIntoConstraints = false
        eventStartLabel.textColor = FeedCellAppearance.textColor
        eventStartLabel.font = FeedCellAppearance.font
        
        eventStartLabel.topAnchor.constraint(
            equalTo: eventNameLabel.bottomAnchor,
            constant: LayoutConstants.topSpace
        ).isActive = true
        
        eventStartLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: LayoutConstants.leftSpace
        ).isActive = true
        
        eventStartLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: LayoutConstants.rightSpace
        ).isActive = true
    }
    
    private func setupEnd() {
        containerView.addSubview(eventEndLabel)
        
        eventEndLabel.translatesAutoresizingMaskIntoConstraints = false
        eventEndLabel.textColor = FeedCellAppearance.textColor
        eventEndLabel.font = FeedCellAppearance.font
        
        eventEndLabel.topAnchor.constraint(
            equalTo: eventStartLabel.bottomAnchor,
            constant: LayoutConstants.topSpace
        ).isActive = true
        
        eventEndLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: LayoutConstants.leftSpace
        ).isActive = true
        
        eventEndLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: LayoutConstants.rightSpace
        ).isActive = true
    }
    
    private func setupCountryCityNameLabel() {
        containerView.addSubview(countryCityNameLabel)
        
        countryCityNameLabel.textColor = FeedCellAppearance.textColor
        countryCityNameLabel.font = FeedCellAppearance.font
        
        countryCityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryCityNameLabel.topAnchor.constraint(equalTo: eventEndLabel.bottomAnchor,
                                                  constant: LayoutConstants.betweenTopSpace).isActive = true
        countryCityNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        countryCityNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
    }
    
    private func setupRatingLabel() {
        containerView.addSubview(ratingLabel)
        
        ratingLabel.textColor = FeedCellAppearance.textColor
        ratingLabel.font = FeedCellAppearance.font
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: countryCityNameLabel.bottomAnchor,
                                                  constant: LayoutConstants.betweenTopSpace).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: LayoutConstants.bottomSpace).isActive = true
        ratingLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        ratingLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
    }
    
    private func setupMaxPersonsLabel() {
        containerView.addSubview(maxPersonsLabel)
        
        maxPersonsLabel.textColor = FeedCellAppearance.textColor
        maxPersonsLabel.font = FeedCellAppearance.font
        
        maxPersonsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        maxPersonsLabel.topAnchor.constraint(
            equalTo: ratingLabel.bottomAnchor,
            constant: LayoutConstants.betweenTopSpace
        ).isActive = true
        
        maxPersonsLabel.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor,
            constant: LayoutConstants.bottomSpace
        ).isActive = true
        
        maxPersonsLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: LayoutConstants.leftSpace
        ).isActive = true
        
        maxPersonsLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: LayoutConstants.rightSpace
        ).isActive = true
    }

}
