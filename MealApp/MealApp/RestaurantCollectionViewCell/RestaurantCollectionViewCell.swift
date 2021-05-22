//
//  RestaurantCollectionViewCell.swift
//  MealApp
//
//  Created by Şule Turp on 22.05.2021.
//

import UIKit
import SDWebImage
extension RestaurantCollectionViewCell {
    fileprivate enum Constants {
        enum Shadow {
            static let opacity: Float = 1
            static let radius: CGFloat = 10
            static let offset = CGSize(width: 0, height: 5)
            static let cornerRadius: CGFloat = 5
        }
        enum UI {
            static let cornerRadius: CGFloat = 5
        }
    }
}

class RestaurantCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var ratingView: StampView!
    @IBOutlet private weak var campaignView: StampView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusView: StampView!
    @IBOutlet private weak var statusImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        containerView.backgroundColor = .white
        titleLabel.textColor = .secondaryColor
        titleLabel.font = .bold(14)
        descriptionLabel.textColor = .secondaryColor
        descriptionLabel.font = .regular(12)
    }

    func configure(restaurant: Restaurant) {
        titleLabel.text = restaurant.name

        prepareBannerImage(with: restaurant.imageUrl)
        prepareRating(rating: restaurant.rating, ratingBackgroundColor: restaurant.ratingBackgroundColor)
        prepareCampaignView(campaignText: restaurant.campaignText)
        prepareStatusView(isClosed: restaurant.closed)
        prepareDescriptionView(restaurant)
        prepareShadow()
    }

    private func prepareShadow() {
        layer.shadowColor = UIColor.verySoftGray.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: Constants.Shadow.cornerRadius).cgPath
        layer.shadowOffset = Constants.Shadow.offset
        layer.shadowOpacity = Constants.Shadow.opacity
        layer.shadowRadius = Constants.Shadow.radius
        layer.masksToBounds = false
        containerView.layer.cornerRadius = Constants.UI.cornerRadius
        containerView.layer.masksToBounds = true
    }


    private func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string: imageUrlString) {
            bannerImageView.sd_setImage(with: url)
        }
    }

    private func prepareRating(rating: Double?, ratingBackgroundColor: String?) {
        if let rating = rating,
           let backgroundColorString = ratingBackgroundColor {
            ratingView.configure(title: String(rating),
                                 font: .bold(14),
                                 backgroundColor: UIColor(hex: backgroundColorString),
                                 image: UIImage(named: "ratingIcon"))
            ratingView.isHidden = false
        } else {
            ratingView.isHidden = true
        }
    }

    private func prepareCampaignView(campaignText: String?) {
        if let campaignText = campaignText, !campaignText.isEmpty {
            campaignView.configure(title: campaignText,
                                   backgroundColor: .primaryColor)
            campaignView.isHidden = false
        } else {
            campaignView.isHidden = true
        }
    }

    private func prepareStatusView(isClosed: Bool?) {
        if isClosed ?? false {
            statusView.configure(title: "Kapalı", backgroundColor: .errorColor)
            statusView.isHidden = false
        } else {
            statusView.isHidden = true
        }
    }

    private func prepareDescriptionView(_ restaurant: Restaurant) {
        let fontRegular: UIFont = .regular(14)
        let fontLight: UIFont = .light(10)
        let bullet: String = " \u{2022} "
        let bulletString = NSMutableAttributedString(string: bullet,
                                                     attributes: [NSAttributedString.Key.font : fontLight,
                                                                  NSAttributedString.Key.foregroundColor : UIColor.gray])
        if restaurant.closed ?? false {
            let attributedString = NSMutableAttributedString(string: restaurant.workingHours,
                                                             attributes: [NSAttributedString.Key.font : fontRegular])
            attributedString.append(bulletString)
            attributedString.append(NSMutableAttributedString(string: restaurant.kitchen,
                                                              attributes: [NSAttributedString.Key.font : fontRegular]))
            descriptionLabel.attributedText = attributedString
        } else {
            let attributedString = NSMutableAttributedString(string: restaurant.averageDeliveryInterval,
                                                             attributes: [NSAttributedString.Key.font : fontRegular])
            attributedString.append(bulletString)
            attributedString.append(NSMutableAttributedString(string: restaurant.averageDeliveryInterval,
                                                              attributes: [NSAttributedString.Key.font : fontRegular]))
            attributedString.append(bulletString)
            attributedString.append(NSMutableAttributedString(string: restaurant.kitchen,
                                                              attributes: [NSAttributedString.Key.font : fontRegular]))
            descriptionLabel.attributedText = attributedString
        }
    }
}
