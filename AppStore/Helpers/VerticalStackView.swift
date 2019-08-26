//
//  VerticalStackView.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/23/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class VStack: UIStackView {

    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .vertical
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
