//
//  HotelTableViewCell.swift
//  Travelly
//
//  Created by Георгий Куликов on 16.04.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let containerViewHeight: CGFloat = 100
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

class HotelTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    
    private let hotelNameLabel = UILabel()
    private let starsLabel = UILabel()
    private let starsImageView = UIImageView()
    private let ratingLabel = UILabel()
    
    private let countryCityNameLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setHotelName(_ hotelName: String) {
        self.hotelNameLabel.text = hotelName
    }
    
    func setStars(_ stars: Int) {
        self.starsLabel.text = "\(stars)"
    }
    
    func setRating(_ rating: Double) {
        self.ratingLabel.text = LayoutConstants.ratingText + "\(rating)"
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

        setupStarsImageView()
        setupStarsLabel()
        setupHotelNameLabel()

        setupCountryCityNameLabel()

        setupRatingLabel()
    }
    
    private func setupStarsImageView() {
        containerView.addSubview(starsImageView)
        
        starsImageView.image = UIImage(named: LayoutConstants.starImageName)
        
        starsImageView.translatesAutoresizingMaskIntoConstraints = false
        starsImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutConstants.topSpace * 0.75).isActive = true
        starsImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: LayoutConstants.rightSpace).isActive = true
        starsImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.starImageSize).isActive = true
        starsImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.starImageSize).isActive = true
    }
    
    private func setupStarsLabel() {
        containerView.addSubview(starsLabel)
        
        starsLabel.textColor = FeedCellAppearance.textColor
        starsLabel.font = FeedCellAppearance.boldFont
        
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        starsLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        starsLabel.rightAnchor.constraint(equalTo: starsImageView.leftAnchor, constant: LayoutConstants.betweenRightSpace).isActive = true
        starsLabel.widthAnchor.constraint(equalToConstant: LayoutConstants.starsWidth).isActive = true
    }
    
    private func setupHotelNameLabel() {
        containerView.addSubview(hotelNameLabel)
        
        hotelNameLabel.textColor = FeedCellAppearance.textColor
        hotelNameLabel.font = FeedCellAppearance.boldFont
        
        hotelNameLabel.translatesAutoresizingMaskIntoConstraints = false
        hotelNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutConstants.topSpace).isActive = true
        hotelNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutConstants.leftSpace).isActive = true
        hotelNameLabel.rightAnchor.constraint(equalTo: starsLabel.leftAnchor, constant: LayoutConstants.betweenRightSpace).isActive = true
    }
    
    private func setupCountryCityNameLabel() {
        containerView.addSubview(countryCityNameLabel)
        
        countryCityNameLabel.textColor = FeedCellAppearance.textColor
        countryCityNameLabel.font = FeedCellAppearance.font
        
        countryCityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryCityNameLabel.topAnchor.constraint(equalTo: hotelNameLabel.bottomAnchor,
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

}
