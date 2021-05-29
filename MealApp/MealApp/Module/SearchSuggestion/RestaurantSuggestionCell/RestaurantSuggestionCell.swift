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
        // Initialization code
    }
}
