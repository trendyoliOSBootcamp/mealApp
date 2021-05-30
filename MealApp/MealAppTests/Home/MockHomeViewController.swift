//
//  MockHomeViewController.swift
//  MealAppTests
//
//  Created by Anıl Taşkıran on 30.05.2021.
//

@testable import MealApp
import UIKit

final class MockHomeViewController: HomeViewInterface {
    func setAccessibilityIdentifiers() { }
    
    var invokedNavigationItemGetter = false
    var invokedNavigationItemGetterCount = 0
    var stubbedNavigationItem: UINavigationItem!

    var navigationItem: UINavigationItem {
        invokedNavigationItemGetter = true
        invokedNavigationItemGetterCount += 1
        return stubbedNavigationItem
    }

    var invokedSearchControllerSetter = false
    var invokedSearchControllerSetterCount = 0
    var invokedSearchController: UISearchController?
    var invokedSearchControllerList = [UISearchController?]()
    var invokedSearchControllerGetter = false
    var invokedSearchControllerGetterCount = 0
    var stubbedSearchController: UISearchController!

    var searchController: UISearchController? {
        set {
            invokedSearchControllerSetter = true
            invokedSearchControllerSetterCount += 1
            invokedSearchController = newValue
            invokedSearchControllerList.append(newValue)
        }
        get {
            invokedSearchControllerGetter = true
            invokedSearchControllerGetterCount += 1
            return stubbedSearchController
        }
    }

    var invokedSearchSuggestionViewControllerGetter = false
    var invokedSearchSuggestionViewControllerGetterCount = 0
    var stubbedSearchSuggestionViewController: UIViewController!

    var searchSuggestionViewController: UIViewController? {
        invokedSearchSuggestionViewControllerGetter = true
        invokedSearchSuggestionViewControllerGetterCount += 1
        return stubbedSearchSuggestionViewController
    }

    var invokedSearchResultUpdatingGetter = false
    var invokedSearchResultUpdatingGetterCount = 0
    var stubbedSearchResultUpdating: UISearchResultsUpdating!

    var searchResultUpdating: UISearchResultsUpdating {
        invokedSearchResultUpdatingGetter = true
        invokedSearchResultUpdatingGetterCount += 1
        return stubbedSearchResultUpdating
    }

    var invokedSearchIconGetter = false
    var invokedSearchIconGetterCount = 0
    var stubbedSearchIcon: UIImage!

    var searchIcon: UIImage? {
        invokedSearchIconGetter = true
        invokedSearchIconGetterCount += 1
        return stubbedSearchIcon
    }

    var invokedHorizontalPaddingGetter = false
    var invokedHorizontalPaddingGetterCount = 0
    var stubbedHorizontalPadding: CGFloat!

    var horizontalPadding: CGFloat {
        invokedHorizontalPaddingGetter = true
        invokedHorizontalPaddingGetterCount += 1
        return stubbedHorizontalPadding
    }

    var invokedPlaceholderGetter = false
    var invokedPlaceholderGetterCount = 0
    var stubbedPlaceholder: String! = ""

    var placeholder: String {
        invokedPlaceholderGetter = true
        invokedPlaceholderGetterCount += 1
        return stubbedPlaceholder
    }

    var invokedPlaceholderFontGetter = false
    var invokedPlaceholderFontGetterCount = 0
    var stubbedPlaceholderFont: UIFont!

    var placeholderFont: UIFont {
        invokedPlaceholderFontGetter = true
        invokedPlaceholderFontGetterCount += 1
        return stubbedPlaceholderFont
    }

    var invokedShowLoadingView = false
    var invokedShowLoadingViewCount = 0

    func showLoadingView() {
        invokedShowLoadingView = true
        invokedShowLoadingViewCount += 1
    }

    var invokedHideLoadingView = false
    var invokedHideLoadingViewCount = 0

    func hideLoadingView() {
        invokedHideLoadingView = true
        invokedHideLoadingViewCount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedEndRefreshing = false
    var invokedEndRefreshingCount = 0

    func endRefreshing() {
        invokedEndRefreshing = true
        invokedEndRefreshingCount += 1
    }

    var invokedPrepareCollectionView = false
    var invokedPrepareCollectionViewCount = 0

    func prepareCollectionView() {
        invokedPrepareCollectionView = true
        invokedPrepareCollectionViewCount += 1
    }

    var invokedAddRefreshControl = false
    var invokedAddRefreshControlCount = 0

    func addRefreshControl() {
        invokedAddRefreshControl = true
        invokedAddRefreshControlCount += 1
    }

    var invokedSetTitle = false
    var invokedSetTitleCount = 0
    var invokedSetTitleParameters: (title: String, Void)?
    var invokedSetTitleParametersList = [(title: String, Void)]()

    func setTitle(_ title: String) {
        invokedSetTitle = true
        invokedSetTitleCount += 1
        invokedSetTitleParameters = (title, ())
        invokedSetTitleParametersList.append((title, ()))
    }

    var invokedPrepareNavigationBarUI = false
    var invokedPrepareNavigationBarUICount = 0

    func prepareNavigationBarUI() {
        invokedPrepareNavigationBarUI = true
        invokedPrepareNavigationBarUICount += 1
    }

    var invokedPrepareSearchController = false
    var invokedPrepareSearchControllerCount = 0

    func prepareSearchController() {
        invokedPrepareSearchController = true
        invokedPrepareSearchControllerCount += 1
    }
}
