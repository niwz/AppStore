//
//  AppDetailController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/23/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {

    private let detailCellId = "DetailCellID"
    private let previewCellId = "PreviewCellID"
    private let reviewsCellId = "ReviewsCellID"

    private let appId: String

    init(appId: String) {
        self.appId = appId
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    var app: Result?
    var reviews: [Entry]?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(ReviewsDisplayCell.self, forCellWithReuseIdentifier: reviewsCellId)
        fetchData()
    }

    private func fetchData() {
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
            let app = result?.results.first
            self.app = app
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        let reviewsUrlString = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
        Service.shared.fetchGenericJSONData(urlString: reviewsUrlString) { (reviews: Reviews?, error) in
            if let error = error {
                print("Failed to decode reviews: ", error)
                return
            }
            self.reviews = reviews?.feed.entries
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            cell.app = app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.app = app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsCellId, for: indexPath) as! ReviewsDisplayCell
            cell.horizontalController.reviews = reviews
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 280
        if indexPath.item == 0 {
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 320
        }
        return .init(width: view.frame.width, height: height)
    }
}
