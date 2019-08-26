//
//  BaseListController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/17/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
