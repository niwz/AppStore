//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/17/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class AppsGroupCell: UICollectionViewCell {

    let titleLabel = UILabel(text: "App Section", font: UIFont.boldSystemFont(ofSize: 24))

    let appsHorizontalController = AppsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(titleLabel, appsHorizontalController.view)
        layout(0,
               |-16-titleLabel,
               |appsHorizontalController.view|,
               0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
