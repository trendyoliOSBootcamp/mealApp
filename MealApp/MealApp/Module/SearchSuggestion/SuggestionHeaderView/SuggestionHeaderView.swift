//
//  SuggestionHeaderView.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import UIKit

class SuggestionHeaderView: UICollectionReusableView {
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = UIColor.secondaryColor
        titleLabel.font = UIFont.bold(14)
    }
}
