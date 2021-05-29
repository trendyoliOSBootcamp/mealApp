//
//  RestaurantSuggestionCell.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import UIKit
import SDWebImage

extension RestaurantSuggestionCell {
    fileprivate enum Constants {
        enum Shadow {
            static let opacity: Float = 1
            static let radius: CGFloat = 10
            static let offset = CGSize(width: 0, height: 5)
            static let cornerRadius: CGFloat = 5
        }
        enum UI {
            static let cornerRadius: CGFloat = 5
            static let fontRegular: UIFont = .regular(14)
            static let fontLight: UIFont = .light(10)
            static let bullet: String = " \u{2022} "
            static let bulletString = NSMutableAttributedString(string: bullet,
                                                                attributes: [NSAttributedString.Key.font : fontLight,
                                                                             NSAttributedString.Key.foregroundColor : UIColor.gray])
        }
    }
}

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
    
    func load(searchItem: SearchItem?) {
        guard let searchItem = searchItem else { return }
        restaurantNameLabel.text = searchItem.title
        kitchenLabel.text = searchItem.kitchen
        
        
        stampView.configure(title: String(searchItem.rating ?? 0),
                                 font: .bold(14),
                                 backgroundColor: UIColor(hex: searchItem.ratingBackgroundColor ?? ""),
                                 image: UIImage(named: "ratingIcon"))
        
        setDescriptionLabel(averageDeliveryInterval: searchItem.averageDeliveryInterval ?? "", minBasketPrice: "\(searchItem.minBasketPrice ?? 0)")
        
        restaurantImageView.sd_setImage(with: URL.init(string: searchItem.imageUrl ?? ""), completed: nil)
    }
    
    func setDescriptionLabel(averageDeliveryInterval: String, minBasketPrice: String) {
        let attributedString = NSMutableAttributedString(string: averageDeliveryInterval,
                                                         attributes: [NSAttributedString.Key.font : Constants.UI.fontRegular])
        attributedString.append(Constants.UI.bulletString)
        attributedString.append(NSMutableAttributedString(string: minBasketPrice,
                                                          attributes: [NSAttributedString.Key.font : Constants.UI.fontRegular]))
        descriptionLabel.attributedText = attributedString
    }
}
