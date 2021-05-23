//
//  NibView.swift
//  meal
//
//  Created by Şule Turp on 15.05.2021.
//

import UIKit

class NibView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }

    func fromNib() {
        if let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                                      owner: self,
                                                      options: nil)?.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
        }
    }
}
