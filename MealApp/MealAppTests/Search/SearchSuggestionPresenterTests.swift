//
//  SearchSuggestionPresenterTests.swift
//  MealAppTests
//
//  Created by Yusuf Özgül on 30.05.2021.
//

import XCTest
@testable import MealApp

class SearchSuggestionPresenterTests: XCTestCase {
    var presenter: SearchSuggestionPresenter!
    var view: MockSearchSuggestionView!
    var router: MockSearchSuggestionRouter!
    var interactor: MockSearchSuggestionInteractor!
    var delegate: MockSearchSuggestionDelegate!
    var throttler: MockThrottler!
    
    override func setUp() {
        view = .init()
        router = .init()
        interactor = .init()
        delegate = .init()
        throttler = .init()
        
        presenter = SearchSuggestionPresenter(view: view,
                                              router: router,
                                              interactor: interactor,
                                              delegate: delegate,
                                              throttler: throttler)
    }

    func test_viewDidLoad_InvokesView() {
        XCTAssertFalse(view.invokedPrepareCollectionView)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareCollectionView)
    }
    
    func test_numberOfItems_NilResponse_ReturnItemCount() {
        
        XCTAssertEqual(presenter.numberOfItems(at: 0), 0)
    }
    
    func test_numberOfItems_ReturnItemCount() {
        presenter.handleFetchSuggestionsResponse(.success(SearchSuggestionResponse.response))
        
        XCTAssertEqual(presenter.numberOfItems(at: 0), 10)
    }
    
    func test_numberOfItems_Section1_ReturnItemCount() {
        presenter.handleFetchSuggestionsResponse(.success(SearchSuggestionResponse.response))
        
        XCTAssertEqual(presenter.numberOfItems(at: 1), 5)
    }
    
    func test_updateSearchResults_InvokesInteractor() {
        XCTAssertFalse(throttler.invokedThrottler)
        XCTAssertFalse(interactor.invokedFetchSuggestions)
        XCTAssertEqual(interactor.invokedFetchSuggestionsCount, 0)
        XCTAssertNil(interactor.invokedFetchSuggestionsParameters?.keyword)
        
        presenter.updateSearchResults(searchText: "Pi")
        
        XCTAssertTrue(throttler.invokedThrottler)
        XCTAssertTrue(interactor.invokedFetchSuggestions)
        XCTAssertEqual(interactor.invokedFetchSuggestionsCount, 1)
        XCTAssertEqual(interactor.invokedFetchSuggestionsParameters?.keyword, "Pi")
    }
    
    func test_handleFetchSuggestionsResponse_InvokesView() {
        XCTAssertFalse(view.invokedReload)
        
        presenter.handleFetchSuggestionsResponse(.success(SearchSuggestionResponse.response))
        
        XCTAssertTrue(view.invokedReload)
    }
    
}

extension SearchSuggestionResponse {
    static var response: SearchSuggestionResponse {
        let bundle = Bundle(for: HomePresenterTests.self)
        let path = bundle.path(forResource: "SearchSuggestionResponse", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SearchSuggestionResponse.self, from: data)
        return response
    }
}
