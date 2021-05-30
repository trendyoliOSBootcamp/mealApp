//
//  BasePage.swift
//  MealAppUITests
//
//  Created by Gökberk İnce on 30.05.2021.
//

import XCTest

class TestHelper {
    var app: XCUIApplication
    static var shared: TestHelper = {
        let testHelper = TestHelper()
        return testHelper
    }()
    
    private init() {
        self.app = XCUIApplication()
    }
    
    func setUpAndLaunch() {
        app.launch()
    }
    
    func terminate() {
        app.terminate()
    }
}
