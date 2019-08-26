//
//  ScreenshotCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/24/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class ScreenshotCell: UICollectionViewCell {

    let imageView = UIImageView(cornerRadius: 12)

    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(imageView)
        imageView.fillContainer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
