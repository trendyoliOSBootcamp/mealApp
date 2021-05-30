//
//  HomePage.swift
//  MealAppUITests
//
//  Created by Gökberk İnce on 30.05.2021.
//
import XCTest

class HomePage {
    var app = TestHelper.shared.app
    
    lazy var navigationBar = app.navigationBars["homePageNavigationBar"]
    lazy var searchBarTextField = app.searchFields["homePageSearchTextField"]
    lazy var cancelButton = app.buttons["Vazgeç"]
    lazy var bannerImageView = "bannerImageView"
    lazy var titleLabel = "titleLabel"
    lazy var statusImageView = "statusImageView"
    lazy var descriptionLabel = "descriptionLabel"
    lazy var favoriteButton = "favoriteButton"
    lazy var productCell = "productCell"
    
    @discardableResult
    func checkNavigationBar() -> Self {
        let _ = navigationBar.waitForExistence(timeout: 3)
        return self
    }
    
    @discardableResult
    func checkSearchBar() -> Self {
        let _ = searchBarTextField.waitForExistence(timeout: 3)
        XCTAssertEqual(searchBarTextField.stringValue, "Yemek Ara")
        return self
    }
    
    @discardableResult
    func tapSearchBar() -> Self {
        let _ = searchBarTextField.waitForExistence(timeout: 3)
        searchBarTextField.tap()
        let _ = cancelButton.waitForExistence(timeout: 3)
        let _ = app.keyboards.element.waitForExistence(timeout: 3)
        return self
    }
    
    @discardableResult
    func getProductCellByIndex(index: Int) -> XCUIElement {
        let cell = app.collectionViews.cells[productCell + "_\(index)"]
        return cell
    }
    
    @discardableResult
    func checkProductCellByIndex(index: Int) -> Self {
        let cell = getProductCellByIndex(index: index)
        let titleLabel = cell.staticTexts[titleLabel]
        let favoriteButton = cell.buttons[favoriteButton]
        let bannerImageView = cell.images[bannerImageView]
        let _ = titleLabel.waitForExistence(timeout: 3)
        let _ = favoriteButton.waitForExistence(timeout: 3)
        let _ = bannerImageView.waitForExistence(timeout: 3)
        XCTAssertEqual(titleLabel.label, "Burger King (Atatürk Mah)")
        XCTAssertEqual(titleLabel.label, "fail")
        return self
    }
}
