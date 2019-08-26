//
//  AppsPageHeader.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/18/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class AppsPageHeader: UICollectionReusableView {

    let appHeaderHorizontalController = AppHeaderHorizontalController()
    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.fillContainer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
