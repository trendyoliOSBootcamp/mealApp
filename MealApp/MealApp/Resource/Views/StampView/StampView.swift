//
//  StampView.swift
//  MealApp
//
//  Created by Şule Turp on 22.05.2021.
//

import UIKit

final class StampView: NibView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var stampImageView: UIImageView!
    @IBOutlet private weak var stampLabel: UILabel!

    func configure(title: String,
                   titleColor: UIColor = .white,
                   font: UIFont? = .semibold(12),
                   backgroundColor: UIColor?,
                   cornerRadius: CGFloat = 5,
                   image: UIImage? = nil) {
        contentView.backgroundColor = backgroundColor
        contentView.layer.cornerRadius = cornerRadius
        stampLabel.text = title
        stampLabel.font = font
        stampLabel.textColor = titleColor

        if let image = image {
            stampImageView.image = image
        } else {
            imageContainerView.isHidden = true
        }
    }
}

