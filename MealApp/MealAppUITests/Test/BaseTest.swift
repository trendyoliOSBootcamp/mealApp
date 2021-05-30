//
//  BaseTest.swift
//  MealAppUITests
//
//  Created by Gökberk İnce on 30.05.2021.
//

import XCTest

class BaseTest: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        TestHelper.shared.setUpAndLaunch()
    }
    
    override func tearDown() {
        super.tearDown()
        let screenshot = XCUIScreen.main.screenshot()
        let fullScreenshotAttachment = XCTAttachment(screenshot: screenshot)
        fullScreenshotAttachment.lifetime = .deleteOnSuccess
        add(fullScreenshotAttachment)
        TestHelper.shared.terminate()
    }
}
