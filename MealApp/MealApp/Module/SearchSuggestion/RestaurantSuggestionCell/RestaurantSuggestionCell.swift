//
//  RestaurantSuggestionCell.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import UIKit

class RestaurantSuggestionCell: UICollectionViewCell {
    @IBOutlet private weak var stampView: StampView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var kitchenLabel: UILabel!
    @IBOutlet private weak var restaurantImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        restaurantNameLabel.font = UIFont.bold(14)
        restaurantNameLabel.textColor = UIColor.secondaryColor
        
        kitchenLabel.font = UIFont.regular(10)
        kitchenLabel.textColor = UIColor.softGray
        
        restaurantImageView.layer.cornerRadius = 10
        restaurantImageView.layer.masksToBounds = true
    }
}
