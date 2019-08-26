//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/18/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class AppsHorizontalController: SnappingHorizontalController, UICollectionViewDelegateFlowLayout {

    var appGroup: AppGroup? {
        didSet {
            collectionView.reloadData()
        }
    }

    private let cellID = "CellID"


    var didSelectHandler: ((FeedResult) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppRowCell
        let app = appGroup?.feed.results[indexPath.item]
        cell.app = app
        return cell
    }

    private let cellPadding: CGFloat = 12
    private let lineSpacing: CGFloat = 10

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * cellPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - 48, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.item] {
            didSelectHandler?(app)
        }
    }
}
