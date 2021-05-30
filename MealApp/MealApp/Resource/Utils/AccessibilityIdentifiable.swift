//
//  AccessibilityIdentifiable.swift
//  MealApp
//
//  Created by Gökberk İnce on 28.05.2021.
//

import UIKit

protocol AccessibilityIdentifiable: AnyObject {
    func setAccessibilityIdentifiers()
    func setAccessibilityIdentifiers(view: UIView, index: Int)
}

extension AccessibilityIdentifiable {
    func setAccessibilityIdentifiers(view: UIView, index: Int) {}
}
