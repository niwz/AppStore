//
//  AppHeaderHorizontalController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/18/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class AppHeaderHorizontalController: SnappingHorizontalController, UICollectionViewDelegateFlowLayout {

    let cellID = "CellID"
    var socialApps: [SocialApp]? {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsHeaderCell
        let app = socialApps?[indexPath.item]
        cell.app = app
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
}
