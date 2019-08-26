//
//  PreviewCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/24/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class PreviewCell: UICollectionViewCell {

    var app: Result? {
        didSet {
            horizontalController.screenshotUrls = app?.screenshotUrls
        }
    }

    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))

    private let horizontalController = PreviewScreenshotsController()

    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(previewLabel, horizontalController.view)
        previewLabel.fillHorizontally(m: 16).top(0)
        previewLabel.Bottom == horizontalController.view.Top - 16
        horizontalController.view.fillHorizontally().bottom(0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
