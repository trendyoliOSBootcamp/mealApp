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
            static let fontRegular: UIFont = .regular(14)
            static let fontLight: UIFont = .light(10)
            static let bullet: String = " \u{2022} "
            static let bulletString = NSMutableAttributedString(string: bullet,
                                                                attributes: [NSAttributedString.Key.font : fontLight,
                                                                             NSAttributedString.Key.foregroundColor : UIColor.gray])
        }
    }
}

final class RestaurantCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var ratingView: StampView!
    @IBOutlet private weak var campaignView: StampView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusView: StampView!
    @IBOutlet private weak var statusImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    var viewModel: RestaurantCollectionViewCellViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.load()
        }
    }

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
}

extension RestaurantCollectionViewCell: RestaurantCollectionViewCellViewModelDelegate {
    func prepareShadow() {
        layer.shadowColor = UIColor.verySoftGray.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: Constants.Shadow.cornerRadius).cgPath
        layer.shadowOffset = Constants.Shadow.offset
        layer.shadowOpacity = Constants.Shadow.opacity
        layer.shadowRadius = Constants.Shadow.radius
        layer.masksToBounds = false
        containerView.layer.cornerRadius = Constants.UI.cornerRadius
        containerView.layer.masksToBounds = true
    }

    func setTitleLabel(_ text: String) {
        titleLabel.text = text
    }

    func prepareBannerImage(with url: URL) {
        bannerImageView.sd_setImage(with: url)
    }

    func prepareRating(rating: Double, ratingBackgroundColor: String) {
        ratingView.configure(title: String(rating),
                             font: .bold(14),
                             backgroundColor: UIColor(hex: ratingBackgroundColor),
                             image: UIImage(named: "ratingIcon"))
    }

    func prepareRatingVisibility(isHidden: Bool) {
        ratingView.isHidden = isHidden
    }

    func prepareCampaignView(campaignText: String) {
        campaignView.configure(title: campaignText,
                               backgroundColor: .primaryColor)
    }

    func prepareCampaignViewVisibility(isHidden: Bool) {
        campaignView.isHidden = isHidden
    }

    func prepareStatusView() {
        statusView.configure(title: "Kapalı", backgroundColor: .errorColor)
    }

    func prepareStatusViewVisibility(isHidden: Bool) {
        statusView.isHidden = isHidden
    }

    func setOpenDescriptionView(averageDeliveryInterval: String, minBasketPrice: String, kitchen: String) {
        let attributedString = NSMutableAttributedString(string: averageDeliveryInterval,
                                                         attributes: [NSAttributedString.Key.font : Constants.UI.fontRegular])
        attributedString.append(Constants.UI.bulletString)
        attributedString.append(NSMutableAttributedString(string: minBasketPrice,
                                                          attributes: [NSAttributedString.Key.font : Constants.UI.fontRegular]))
        attributedString.append(Constants.UI.bulletString)
        attributedString.append(NSMutableAttributedString(string: kitchen,
                                                          attributes: [NSAttributedString.Key.font : Constants.UI.fontRegular]))
        descriptionLabel.attributedText = attributedString
    }

    func setClosedDescriptionView(workingHours: String, kitchen: String) {
        let attributedString = NSMutableAttributedString(string: workingHours,
                                                         attributes: [NSAttributedString.Key.font : Constants.UI.fontRegular])
        attributedString.append(Constants.UI.bulletString)
        attributedString.append(NSMutableAttributedString(string: kitchen,
                                                          attributes: [NSAttributedString.Key.font : Constants.UI.fontRegular]))
        descriptionLabel.attributedText = attributedString
    }
}
