//
//  XCElement+Extension.swift
//  UITests
//
//  Created by Gökberk İnce on 27.05.2020.
//  Copyright © 2020 Trendyol.com. All rights reserved.
//

import XCTest

enum SwipeDirection {
    case swipeUp
    case swipeDown
    case swipeRight
    case swipeLeft
}

enum PinchType: CGFloat {
    case pinchIn = 2
    case pinchOut = 0.5
}

extension XCUIElement {
    var stringValue: String {
        return value as? String ?? ""
    }
    
    func forceTapElement() {
        let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        coordinate.tap()
    }
    
    func getMidCoordinates() -> XCUICoordinate {
        return coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    }
    
    func swipe(swipeDirection: SwipeDirection) {
        switch swipeDirection {
        case .swipeUp:
            swipeUp()
        case .swipeDown:
            swipeDown()
        case .swipeRight:
            swipeRight()
        case .swipeLeft:
            swipeLeft()
        }
    }
    
    func pinch(pinchType: PinchType) {
        switch pinchType {
        case .pinchIn:
            pinch(withScale: pinchType.rawValue, velocity: 1)
        case .pinchOut:
            pinch(withScale: pinchType.rawValue, velocity: -1)
        }
    }
    
    func longSwipeLeft() {
        let cell = self
        let rightOffset = CGVector(dx: 0.95, dy: 0.5)
        let leftOffset = CGVector(dx: 0.05, dy: 0.5)
        let cellFarRightCoordinate = cell.coordinate(withNormalizedOffset: rightOffset)
        let cellFarLeftCoordinate = cell.coordinate(withNormalizedOffset: leftOffset)
        cellFarRightCoordinate.press(forDuration: 0.1, thenDragTo: cellFarLeftCoordinate)
    }
    
    func longSwipeUp() {
        let cell = self
        let bottomOffset = CGVector(dx: 0.5, dy: 0.0)
        let topOffset = CGVector(dx: 0.5, dy: 1.0)
        let cellBottomCoordinate = cell.coordinate(withNormalizedOffset: bottomOffset)
        let cellTopCoordinate = cell.coordinate(withNormalizedOffset: topOffset)
        cellTopCoordinate.press(forDuration: 0.1, thenDragTo: cellBottomCoordinate)
    }
    
    func minimalSwipeUp() {
        let cell = self
        let dragCoordinates = cell.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.4))
        let coordinates = cell.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.7))
        coordinates.press(forDuration: 0.1, thenDragTo: dragCoordinates)
    }
    
    func clearAndEnterText(text: String) {
        guard let stringValue = value as? String else {
            XCTFail()
            return
        }
        let lowerRightCorner = coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
        lowerRightCorner.tap()
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
        typeText(text)
    }
}
