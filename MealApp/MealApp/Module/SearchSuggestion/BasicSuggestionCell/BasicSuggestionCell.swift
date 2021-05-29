//
//  BasicSuggestionCell.swift
//  MealApp
//
//  Created by Emre Ergün on 29.05.2021.
//

import UIKit

class BasicSuggestionCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont.semibold(14)
        titleLabel.textColor = UIColor.secondaryColor
    }
}
