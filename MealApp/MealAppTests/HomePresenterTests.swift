//
//  HomePresenterTests.swift
//  MealAppTests
//
//  Created by Anıl Taşkıran on 30.05.2021.
//

import XCTest
@testable import MealApp

class HomePresenterTests: XCTestCase {
    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        presenter = .init(view: view, interactor: interactor)
    }


    //    func test_viewDidLoad_InvokesRequiredViewMethods() {
    //        XCTAssertFalse(view.isShowLoadingViewInvoked)
    //        XCTAssertFalse(interactor.isFetchWidgetsInvoked)
    //        XCTAssertNil(interactor.fetchWidgetsInvokedWithQuery)
    ////         GIVEN
    //
    //        presenter.viewDidLoad()
    ////        WHEN
    //
    //        XCTAssertTrue(view.isShowLoadingViewInvoked)
    //        XCTAssertTrue(interactor.isFetchWidgetsInvoked)
    //        XCTAssertEqual(interactor.fetchWidgetsInvokedWithQuery, "page=1")
    ////        Then
    //
    //    }

    func test_viewDidLoad_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.invokedPrepareNavigationBarUI)
        XCTAssertFalse(view.invokedSetTitle)
        XCTAssertNil(view.invokedSetTitleParameters)
        XCTAssertFalse(view.invokedPrepareSearchController)
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(view.invokedAddRefreshControl)
        XCTAssertFalse(view.invokedShowLoadingView)
        XCTAssertFalse(interactor.invokedFetchWidgets)
        XCTAssertNil(interactor.invokedFetchWidgetsParameters)

        presenter.viewDidLoad()

        XCTAssertTrue(view.invokedPrepareNavigationBarUI)
        XCTAssertTrue(view.invokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleParameters?.title, "Home")
        XCTAssertTrue(view.invokedPrepareSearchController)
        XCTAssertTrue(view.invokedPrepareCollectionView)
        XCTAssertTrue(view.invokedAddRefreshControl)
        XCTAssertTrue(view.invokedShowLoadingView)
        XCTAssertTrue(interactor.invokedFetchWidgets)
        XCTAssertEqual(interactor.invokedFetchWidgetsParameters?.query, "page=1")
    }

    func test_willDisplay_WithIndexZero_InvokesNothing() {
        XCTAssertFalse(view.invokedShowLoadingView)
        XCTAssertFalse(interactor.invokedFetchWidgets)
        XCTAssertNil(interactor.invokedFetchWidgetsParameters)

        presenter.willDisplay(0)

        XCTAssertFalse(view.invokedShowLoadingView)
        XCTAssertFalse(interactor.invokedFetchWidgets)
        XCTAssertNil(interactor.invokedFetchWidgetsParameters)
    }

    func test_WillDisplay_WithValidIndex_InvokesFetchWidgets() {
        presenter.handleWidgetResult(.success(.response), query: "1")

        XCTAssertFalse(view.invokedShowLoadingView)
        XCTAssertFalse(interactor.invokedFetchWidgets)
        XCTAssertNil(interactor.invokedFetchWidgetsParameters)
        presenter.willDisplay(9)

        XCTAssertTrue(view.invokedShowLoadingView)
        XCTAssertTrue(interactor.invokedFetchWidgets)
        XCTAssertEqual(interactor.invokedFetchWidgetsParameters?.query, "page=2")
    }

    func test_handleWidgetResult_WithSuccessResponseAndFirstPage_InvokesRequeiredViews() {
        XCTAssertFalse(view.invokedHideLoadingView)
        XCTAssertEqual(presenter.numberOfItems, 0)
        XCTAssertFalse(view.invokedReloadData)
        XCTAssertFalse(view.invokedEndRefreshing)

        presenter.handleWidgetResult(.success(.response), query: "page=1")

        XCTAssertTrue(view.invokedHideLoadingView)
        XCTAssertEqual(presenter.numberOfItems, 10)
        XCTAssertTrue(view.invokedReloadData)
        XCTAssertTrue(view.invokedEndRefreshing)
    }
}

extension HomeResponse {
    static var response: HomeResponse {
        let bundle = Bundle(for: HomePresenterTests.self)
        let path = bundle.path(forResource: "HomeResponse", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let homeResponse = try! JSONDecoder().decode(HomeResponse.self, from: data)
        return homeResponse
    }
}
