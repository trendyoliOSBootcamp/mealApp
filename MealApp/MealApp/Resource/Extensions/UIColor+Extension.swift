//
//  UIColor+Extension.swift
//  meal
//
//  Created by Şule Turp on 15.05.2021.
//

import UIKit

extension UIColor {
    class var primaryColor: UIColor {
        UIColor(hex: "f27a1a")
    }

    class var secondaryColor: UIColor {
        UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    }
    
    class var softGray: UIColor {
        UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
    }

    class var verySoftGray: UIColor {
        UIColor(red: 230/255, green: 230/255 , blue: 230/255, alpha: 1)
    }

    class var errorColor: UIColor {
        UIColor(red: 208/255, green: 2/255 , blue: 28/255, alpha: 1)
    }

    convenience init(hex: String) {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        guard hexString.count == 6 else {
            self.init(red: 153 / 255.0,
                      green: 153 / 255.0,
                      blue: 153 / 255.0,
                      alpha: 1)
            return
        }
        var rgbValue: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
}
