//
//  PreviewScreenshotsController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/24/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: SnappingHorizontalController, UICollectionViewDelegateFlowLayout {

    var screenshotUrls: [String]? {
        didSet {
            collectionView.reloadData()
        }
    }

    private let screenshotCellId = "ScreenshotCellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: screenshotCellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotUrls?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotCellId, for: indexPath) as! ScreenshotCell
        let screenshotUrl = screenshotUrls?[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: screenshotUrl ?? ""))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}
