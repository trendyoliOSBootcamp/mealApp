//
//  MockRestaurantCollectionViewCell.swift
//  MealAppTests
//
//  Created by Mine on 30.05.2021.
//

import Foundation
@testable import MealApp

final class MockRestaurantCollectionViewCell: RestaurantCollectionViewCellInterface {
    var invokedPrepareShadow = false
    var invokedPrepareShadowCount = 0

    func prepareShadow() {
        invokedPrepareShadow = true
        invokedPrepareShadowCount += 1
    }

    var invokedSetTitleLabel = false
    var invokedSetTitleLabelCount = 0
    var invokedSetTitleLabelParameters: (text: String, Void)?
    var invokedSetTitleLabelParametersList = [(text: String, Void)]()

    func setTitleLabel(_ text: String) {
        invokedSetTitleLabel = true
        invokedSetTitleLabelCount += 1
        invokedSetTitleLabelParameters = (text, ())
        invokedSetTitleLabelParametersList.append((text, ()))
    }

    var invokedPrepareBannerImage = false
    var invokedPrepareBannerImageCount = 0
    var invokedPrepareBannerImageParameters: (url: URL, Void)?
    var invokedPrepareBannerImageParametersList = [(url: URL, Void)]()

    func prepareBannerImage(with url: URL) {
        invokedPrepareBannerImage = true
        invokedPrepareBannerImageCount += 1
        invokedPrepareBannerImageParameters = (url, ())
        invokedPrepareBannerImageParametersList.append((url, ()))
    }

    var invokedPrepareRating = false
    var invokedPrepareRatingCount = 0
    var invokedPrepareRatingParameters: (rating: Double, ratingBackgroundColor: String)?
    var invokedPrepareRatingParametersList = [(rating: Double, ratingBackgroundColor: String)]()

    func prepareRating(rating: Double, ratingBackgroundColor: String) {
        invokedPrepareRating = true
        invokedPrepareRatingCount += 1
        invokedPrepareRatingParameters = (rating, ratingBackgroundColor)
        invokedPrepareRatingParametersList.append((rating, ratingBackgroundColor))
    }

    var invokedPrepareRatingVisibility = false
    var invokedPrepareRatingVisibilityCount = 0
    var invokedPrepareRatingVisibilityParameters: (isHidden: Bool, Void)?
    var invokedPrepareRatingVisibilityParametersList = [(isHidden: Bool, Void)]()

    func prepareRatingVisibility(isHidden: Bool) {
        invokedPrepareRatingVisibility = true
        invokedPrepareRatingVisibilityCount += 1
        invokedPrepareRatingVisibilityParameters = (isHidden, ())
        invokedPrepareRatingVisibilityParametersList.append((isHidden, ()))
    }

    var invokedPrepareCampaignView = false
    var invokedPrepareCampaignViewCount = 0
    var invokedPrepareCampaignViewParameters: (campaignText: String, Void)?
    var invokedPrepareCampaignViewParametersList = [(campaignText: String, Void)]()

    func prepareCampaignView(campaignText: String) {
        invokedPrepareCampaignView = true
        invokedPrepareCampaignViewCount += 1
        invokedPrepareCampaignViewParameters = (campaignText, ())
        invokedPrepareCampaignViewParametersList.append((campaignText, ()))
    }

    var invokedPrepareCampaignViewVisibility = false
    var invokedPrepareCampaignViewVisibilityCount = 0
    var invokedPrepareCampaignViewVisibilityParameters: (isHidden: Bool, Void)?
    var invokedPrepareCampaignViewVisibilityParametersList = [(isHidden: Bool, Void)]()

    func prepareCampaignViewVisibility(isHidden: Bool) {
        invokedPrepareCampaignViewVisibility = true
        invokedPrepareCampaignViewVisibilityCount += 1
        invokedPrepareCampaignViewVisibilityParameters = (isHidden, ())
        invokedPrepareCampaignViewVisibilityParametersList.append((isHidden, ()))
    }

    var invokedPrepareStatusView = false
    var invokedPrepareStatusViewCount = 0

    func prepareStatusView() {
        invokedPrepareStatusView = true
        invokedPrepareStatusViewCount += 1
    }

    var invokedPrepareStatusViewVisibility = false
    var invokedPrepareStatusViewVisibilityCount = 0
    var invokedPrepareStatusViewVisibilityParameters: (isHidden: Bool, Void)?
    var invokedPrepareStatusViewVisibilityParametersList = [(isHidden: Bool, Void)]()

    func prepareStatusViewVisibility(isHidden: Bool) {
        invokedPrepareStatusViewVisibility = true
        invokedPrepareStatusViewVisibilityCount += 1
        invokedPrepareStatusViewVisibilityParameters = (isHidden, ())
        invokedPrepareStatusViewVisibilityParametersList.append((isHidden, ()))
    }

    var invokedSetOpenDescriptionView = false
    var invokedSetOpenDescriptionViewCount = 0
    var invokedSetOpenDescriptionViewParameters: (averageDeliveryInterval: String, minBasketPrice: String, kitchen: String)?
    var invokedSetOpenDescriptionViewParametersList = [(averageDeliveryInterval: String, minBasketPrice: String, kitchen: String)]()

    func setOpenDescriptionView(averageDeliveryInterval: String, minBasketPrice: String, kitchen: String) {
        invokedSetOpenDescriptionView = true
        invokedSetOpenDescriptionViewCount += 1
        invokedSetOpenDescriptionViewParameters = (averageDeliveryInterval, minBasketPrice, kitchen)
        invokedSetOpenDescriptionViewParametersList.append((averageDeliveryInterval, minBasketPrice, kitchen))
    }

    var invokedSetClosedDescriptionView = false
    var invokedSetClosedDescriptionViewCount = 0
    var invokedSetClosedDescriptionViewParameters: (workingHours: String, kitchen: String)?
    var invokedSetClosedDescriptionViewParametersList = [(workingHours: String, kitchen: String)]()

    func setClosedDescriptionView(workingHours: String, kitchen: String) {
        invokedSetClosedDescriptionView = true
        invokedSetClosedDescriptionViewCount += 1
        invokedSetClosedDescriptionViewParameters = (workingHours, kitchen)
        invokedSetClosedDescriptionViewParametersList.append((workingHours, kitchen))
    }
}
