//
//  RestaurantCollectionViewCellViewModel.swift
//  MealApp
//
//  Created by Beyza İnce on 23.05.2021.
//

import Foundation


protocol RestaurantCollectionViewCellViewModelProtocol {
    var delegate: RestaurantCollectionViewCellViewModelDelegate? { get set }

    func load()
}

protocol RestaurantCollectionViewCellViewModelDelegate: AnyObject {
  func prepareShadow()
    func setTitleLabel(_ text: String)
    func prepareBannerImage(with url: URL)
    func prepareRating(rating: Double, ratingBackgroundColor: String)
    func prepareRatingVisibility(isHidden: Bool)
    func prepareCampaignView(campaignText: String)
    func prepareCampaignViewVisibility(isHidden: Bool)
    func prepareStatusView()
    func prepareStatusViewVisibility(isHidden: Bool)
    func setOpenDescriptionView(averageDeliveryInterval: String, minBasketPrice: String, kitchen: String)
    func setClosedDescriptionView(workingHours: String, kitchen: String)
}

final class RestaurantCollectionViewCellViewModel {
    private let restaurant: Restaurant
    weak var delegate: RestaurantCollectionViewCellViewModelDelegate?

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    private func setRestaurantRating() {
        if let rating = restaurant.rating,
           let backgroundColorString = restaurant.ratingBackgroundColor {
            delegate?.prepareRating(rating: rating, ratingBackgroundColor: backgroundColorString)
            delegate?.prepareRatingVisibility(isHidden: false)
        } else  {
            delegate?.prepareRatingVisibility(isHidden: true)
        }
    }

    private func setCampaignView() {
        if let campaignText = restaurant.campaignText, !campaignText.isEmpty {
            delegate?.prepareCampaignView(campaignText: campaignText)
            delegate?.prepareCampaignViewVisibility(isHidden: false)
        } else {
            delegate?.prepareCampaignViewVisibility(isHidden: true)
        }
    }

    private func setStatusView() {
        if restaurant.closed ?? false {
            delegate?.prepareStatusView()
            delegate?.prepareStatusViewVisibility(isHidden: false)
        } else {
            delegate?.prepareStatusViewVisibility(isHidden: true)
        }
    }

    private func setDescriptionView() {
        if restaurant.closed ?? false {
            delegate?.setClosedDescriptionView(workingHours: restaurant.workingHours, kitchen: restaurant.kitchen)
        } else if let minBasketPrice = restaurant.minBasketPrice {
            delegate?.setOpenDescriptionView(averageDeliveryInterval: restaurant.averageDeliveryInterval, minBasketPrice: "\(minBasketPrice)", kitchen: restaurant.kitchen)
        }
    }
}

extension RestaurantCollectionViewCellViewModel: RestaurantCollectionViewCellViewModelProtocol {
    func load() {
        delegate?.prepareShadow()
        if let imageUrlString = restaurant.imageUrl, let url = URL(string: imageUrlString) {
            delegate?.prepareBannerImage(with: url)
        }
        delegate?.setTitleLabel(restaurant.name ?? "")
        setCampaignView()
        setStatusView()
        setRestaurantRating()
        setDescriptionView()
    }
}
