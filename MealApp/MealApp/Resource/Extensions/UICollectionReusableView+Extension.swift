//
//  UICollectionReusableView+Extension.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import UIKit

extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
