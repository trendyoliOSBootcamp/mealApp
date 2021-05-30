//
//  RestaurantCollectionCellPresenterTests.swift
//  MealAppTests
//
//  Created by Mine on 30.05.2021.
//

import XCTest
@testable import MealApp

class RestaurantCollectionCellPresenterTests: XCTestCase {
    var view: MockRestaurantCollectionViewCell!
    var delegate: MockRestaurantCollectionDelegate!
    var presenter: RestaurantCollectionCellPresenter!

    override func setUp() {
        super.setUp()
        view = .init()
        delegate = .init()
        reCreate(rating: 10)
    }

    private func reCreate(rating: Double? = nil,
                          ratingBackgroundColor: String? = nil,
                          imageUrl: String? = nil,
                          campaignText: String? = nil,
                          closed: Bool? = false) {
        let restaurant = Restaurant(id: nil,
                                    imageUrl: imageUrl,
                                    logoUrl: nil,
                                    deeplink: nil,
                                    name: nil,
                                    averageDeliveryInterval: "",
                                    minBasketPrice: nil,
                                    kitchen: "",
                                    rating: rating,
                                    ratingText: nil,
                                    campaignText: campaignText,
                                    ratingBackgroundColor: ratingBackgroundColor,
                                    isClosed: nil,
                                    deliveryTypeImage: nil,
                                    workingHours: "",
                                    workingHoursInterval: nil,
                                    location: nil,
                                    closed: closed)
        presenter = .init(view: view,
                          restaurant: restaurant,
                          delegate: delegate)

    }

    func test_load_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokedPrepareShadow)
        XCTAssertFalse(view.invokedSetTitleLabel)
        XCTAssertNil(view.invokedSetTitleLabelParameters)

        presenter.load()

        XCTAssertTrue(view.invokedPrepareShadow)
        XCTAssertTrue(view.invokedSetTitleLabel)
        XCTAssertEqual(view.invokedSetTitleLabelParameters?.text, "")
    }

    func test_load_WithNilImageUrl_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokedPrepareBannerImage)

        presenter.load()

        XCTAssertFalse(view.invokedPrepareBannerImage)
    }

    func test_load_WithEmptyImageUrl_InvokesRequiredMethods() {
        reCreate(imageUrl: "")

        XCTAssertFalse(view.invokedPrepareBannerImage)

        presenter.load()

        XCTAssertFalse(view.invokedPrepareBannerImage)
    }

    func test_load_WithImageUrl_InvokesRequiredMethods() {
        reCreate(imageUrl: "imageUrl")

        XCTAssertFalse(view.invokedPrepareBannerImage)
        XCTAssertNil(view.invokedPrepareBannerImageParameters)

        presenter.load()

        XCTAssertTrue(view.invokedPrepareBannerImage)
        XCTAssertEqual(view.invokedPrepareBannerImageParameters?.url, URL(string: "imageUrl"))
    }

    func test_load_WithEmptyCampaignText_InvokesPrepareCampaignViewVisibility() {
        XCTAssertFalse(view.invokedPrepareCampaignViewVisibility)
        XCTAssertNil(view.invokedPrepareCampaignViewVisibilityParameters)

        presenter.load()

        XCTAssertTrue(view.invokedPrepareCampaignViewVisibility)
        XCTAssertEqual(view.invokedPrepareCampaignViewVisibilityParameters?.isHidden, true)
    }

    func test_load_WithCampaignText_InvokesPrepareCampaignViews() {
        reCreate(campaignText: "campaignText")

        XCTAssertFalse(view.invokedPrepareCampaignView)
        XCTAssertNil(view.invokedPrepareCampaignViewParameters)
        XCTAssertFalse(view.invokedPrepareCampaignViewVisibility)
        XCTAssertNil(view.invokedPrepareCampaignViewVisibilityParameters)

        presenter.load()

        XCTAssertTrue(view.invokedPrepareCampaignView)
        XCTAssertEqual(view.invokedPrepareCampaignViewParameters?.campaignText, "campaignText")
        XCTAssertTrue(view.invokedPrepareCampaignViewVisibility)
        XCTAssertEqual(view.invokedPrepareCampaignViewVisibilityParameters?.isHidden, false)
    }

    func test_load_WithClosedIsFalse_InvokesViewMethods() {
        XCTAssertFalse(view.invokedPrepareStatusViewVisibility)
        XCTAssertFalse(view.invokedPrepareStatusView)
        XCTAssertNil(view.invokedPrepareStatusViewVisibilityParameters)

        presenter.load()

        XCTAssertTrue(view.invokedPrepareStatusViewVisibility)
        XCTAssertFalse(view.invokedPrepareStatusView)
        XCTAssertEqual(view.invokedPrepareStatusViewVisibilityParameters?.isHidden, true)
    }

    func test_load_WithClosedIsTrue_InvokesViewMethods() {
        reCreate(closed: true)

        XCTAssertFalse(view.invokedPrepareStatusViewVisibility)
        XCTAssertFalse(view.invokedPrepareStatusView)
        XCTAssertNil(view.invokedPrepareStatusViewVisibilityParameters)

        presenter.load()

        XCTAssertTrue(view.invokedPrepareStatusViewVisibility)
        XCTAssertTrue(view.invokedPrepareStatusView)
        XCTAssertEqual(view.invokedPrepareStatusViewVisibilityParameters?.isHidden, false)
    }
}

