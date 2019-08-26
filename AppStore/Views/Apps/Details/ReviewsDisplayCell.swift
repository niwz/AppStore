//
//  ReviewsDisplayCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/24/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class ReviewsDisplayCell: UICollectionViewCell {

    let reviewsLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 20))

    let horizontalController = ReviewsController()

    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(reviewsLabel, horizontalController.view)
        reviewsLabel.fillHorizontally(m: 20).top(20)
        horizontalController.view.Top == reviewsLabel.Bottom + 20
        horizontalController.view.fillHorizontally().bottom(0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
