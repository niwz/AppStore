//
//  ReviewsController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/24/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class ReviewsController: SnappingHorizontalController, UICollectionViewDelegateFlowLayout {

    var reviews: [Entry]? {
        didSet {
            collectionView.reloadData()
        }
    }

    private let reviewCellID = "ReviewCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellID)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellID, for: indexPath) as! ReviewCell
        let review = reviews?[indexPath.item]
        cell.review = review
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height - 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
}
