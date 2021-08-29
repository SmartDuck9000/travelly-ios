//
//  TourTableViewCell.swift
//  Travelly
//
//  Created by Георгий Куликов on 28.08.2021.
//

import UIKit

fileprivate struct LayoutConstants {
    static let containerViewHeight: CGFloat = 140
    static let containerViewTopSpace: CGFloat = 10
    static let containerViewBottomSpace: CGFloat = -10
    static let containerViewLeftSpace: CGFloat = 15
    static let containerViewRightSpace: CGFloat = -15
}

class TourTableViewCell: UITableViewCell {
    
    private var containerView = UIView()
    
    private var nameLabel = UILabel()
    private var priceLabel = UILabel()
    private var dateFromLabel = UILabel()
    private var dateToLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: ToursModel) {
        nameLabel.text = model.tour_name
        priceLabel.text = "Цена: \(model.tour_price)"
        dateFromLabel.text = "Начало: \(model.tour_date_from)"
        dateToLabel.text = "Конец: \(model.tour_date_to)"
    }
    
    func setupCell() {
        containerView.frame = CGRect(x: LayoutConstants.containerViewLeftSpace,
                                     y: LayoutConstants.containerViewTopSpace,
                                     width: self.frame.width - LayoutConstants.containerViewLeftSpace * 2,
                                     height: LayoutConstants.containerViewHeight)
        containerView.backgroundColor = FeedCellAppearance.backgroungColor
        containerView.layer.cornerRadius = self.frame.width / 40
        self.addSubview(containerView)
        
        setupNameLabel()
        setupPriceLabel()
        setupDateFromLabel()
        setupDateToLabel()
    }
    
    func setupNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        nameLabel.font = FeedCellAppearance.boldFont
        
        nameLabel.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: 15
        ).isActive = true
        
        nameLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: 10
        ).isActive = true
        
        nameLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    func setupPriceLabel() {
        containerView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = .white
        
        priceLabel.topAnchor.constraint(
            equalTo: nameLabel.bottomAnchor,
            constant: 10
        ).isActive = true
        
        priceLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: 10
        ).isActive = true
        
        priceLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    func setupDateFromLabel() {
        containerView.addSubview(dateFromLabel)
        dateFromLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFromLabel.textColor = .white
        
        dateFromLabel.topAnchor.constraint(
            equalTo: priceLabel.bottomAnchor,
            constant: 10
        ).isActive = true
        
        dateFromLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: 10
        ).isActive = true
        
        dateFromLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: -10
        ).isActive = true
    }
    
    func setupDateToLabel() {
        containerView.addSubview(dateToLabel)
        dateToLabel.translatesAutoresizingMaskIntoConstraints = false
        dateToLabel.textColor = .white
        
        dateToLabel.topAnchor.constraint(
            equalTo: dateFromLabel.bottomAnchor,
            constant: 10
        ).isActive = true
        
        dateToLabel.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: 10
        ).isActive = true
        
        dateToLabel.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: -10
        ).isActive = true
    }
}
