//
//  SnappingHorizontalController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/21/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class SnappingHorizontalController: UICollectionViewController {

    init() {
        let layout = SnappingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
