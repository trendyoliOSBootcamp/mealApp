//
//  UIFont+Extension.swift
//  meal
//
//  Created by Şule Turp on 15.05.2021.
//

import UIKit

extension UIFont {
    public static func light(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Light", size: CGFloat(size))!
    }

    public static func thin(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Thin", size: CGFloat(size))!
    }

    public static func regular(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Regular", size: CGFloat(size))!
    }

    public static func semibold(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Semibold", size: CGFloat(size))!
    }

    public static func bold(_ size: Int) -> UIFont {
        UIFont(name: "Lato-Bold", size: CGFloat(size))!
    }
}

