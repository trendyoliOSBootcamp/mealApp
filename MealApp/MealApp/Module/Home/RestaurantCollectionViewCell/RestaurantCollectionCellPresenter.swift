//
//  RestaurantCollectionCellPresenter.swift
//  MealApp
//
//  Created by Mine on 23.05.2021.
//

import Foundation

//Cell -> RestaurantCollectionCellPresenterInterface
protocol RestaurantCollectionCellPresenterInterface {
    func load()
    func favoriteButtonTapped()
}

protocol RestaurantCollectionDelegate: AnyObject {
    func favoriteButtonTapped()
}

final class RestaurantCollectionCellPresenter {
    weak var view: RestaurantCollectionViewCellInterface?
    weak var delegate: RestaurantCollectionDelegate?
    private let restaurant: Restaurant

    init(view: RestaurantCollectionViewCellInterface?,
         restaurant: Restaurant,
         delegate: RestaurantCollectionDelegate?) {
        self.view = view
        self.restaurant = restaurant
        self.delegate = delegate
    }

    private func setRestaurantRating() {
        if let rating = restaurant.rating,
           let backgroundColorString = restaurant.ratingBackgroundColor {
            view?.prepareRating(rating: rating, ratingBackgroundColor: backgroundColorString)
            view?.prepareRatingVisibility(isHidden: false)
        } else  {
            view?.prepareRatingVisibility(isHidden: true)
        }
    }

    private func setCampaignView() {
        if let campaignText = restaurant.campaignText, !campaignText.isEmpty {
            view?.prepareCampaignView(campaignText: campaignText)
            view?.prepareCampaignViewVisibility(isHidden: false)
        } else {
            view?.prepareCampaignViewVisibility(isHidden: true)
        }
    }

    private func setStatusView() {
        if restaurant.closed ?? false {
            view?.prepareStatusView()
            view?.prepareStatusViewVisibility(isHidden: false)
        } else {
            view?.prepareStatusViewVisibility(isHidden: true)
        }
    }

    private func setDescriptionView() {
        if restaurant.closed ?? false {
            view?.setClosedDescriptionView(workingHours: restaurant.workingHours, kitchen: restaurant.kitchen)
        } else if let minBasketPrice = restaurant.minBasketPrice {
            view?.setOpenDescriptionView(averageDeliveryInterval: restaurant.averageDeliveryInterval, minBasketPrice: "\(minBasketPrice)", kitchen: restaurant.kitchen)
        }
    }
}

extension RestaurantCollectionCellPresenter: RestaurantCollectionCellPresenterInterface {
    func favoriteButtonTapped() {
        delegate?.favoriteButtonTapped()
    }

    func load() {
        view?.prepareShadow()
        if let imageUrlString = restaurant.imageUrl, let url = URL(string: imageUrlString) {
            view?.prepareBannerImage(with: url)
        }
        view?.setTitleLabel(restaurant.name ?? "")
        setCampaignView()
        setStatusView()
        setRestaurantRating()
        setDescriptionView()
    }
}
