//
//  ProfileOptionTableViewCell.swift
//  Travelly
//
//  Created by Георгий Куликов on 29.03.2021.
//

import UIKit

class ProfileOptionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setOptionName(_ name: String) {
        self.textLabel?.text = name
    }
    
    func setTextColor(_ color: UIColor) {
        self.textLabel?.textColor = color
    }
    
    func setImage(_ image: UIImage?) {
        self.imageView?.image = image
    }

    func setupCell() {
        self.backgroundColor = TableViewCellAppearance.backgroungColor
        self.textLabel?.textColor = TableViewCellAppearance.textColor
        self.textLabel?.font = TableViewCellAppearance.font
    }
}
