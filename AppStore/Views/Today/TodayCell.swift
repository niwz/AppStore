//
//  TodayCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/25/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class TodayCell: UICollectionViewCell {

    let imageView = UIImageView(image: UIImage(named: "garden"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        sv(imageView)
        imageView.centerInContainer().size(250)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
