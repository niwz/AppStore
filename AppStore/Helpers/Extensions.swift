//
//  Extensions.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/18/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
