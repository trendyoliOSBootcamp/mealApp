//
//  HomeTest.swift
//  MealAppUITests
//
//  Created by Gökberk İnce on 30.05.2021.
//

class HomeTest: BaseTest {
    
    func testNavigationBar() {
        HomePage()
            .checkNavigationBar()
            .checkSearchBar()
            .tapSearchBar()
            .checkProductCellByIndex(index: 0)
    }
}
