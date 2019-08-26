//
//  AppsPageController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/17/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {

    let cellID = "CellID"
    let headerID = "HeaderID"
    var socialApps = [SocialApp]()
    var groups = [AppGroup]()
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        view.sv(activityIndicatorView)
        activityIndicatorView.fillContainer()
        fetchData()
    }

    private func fetchData() {
        print("Fetching data...")
        var games: AppGroup?
        var topGrossing: AppGroup?
        var topFree: AppGroup?
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (apps, error) in
            if let error = error {
                print("Failed to fetch social apps: ", error)
            }
            self.socialApps = apps ?? []
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        Service.shared.fetchGames(completion: ({ (appGroup, error) in
            if let error = error {
                print("Failed to fetch games: ", error)
            }
            games = appGroup
            dispatchGroup.leave()
        }))

        dispatchGroup.enter()
        Service.shared.fetchTopGrossing(completion: ({ (appGroup, error) in
            if let error = error {
                print("Failed to fetch top grossing: ", error)
            }
            topGrossing = appGroup
            dispatchGroup.leave()
        }))

        dispatchGroup.enter()
        Service.shared.fetchTopFree(completion: ({ (appGroup, error) in
            if let error = error {
                print("Failed to fetch top free: ", error)
            }
            topFree = appGroup
            dispatchGroup.leave()
        }))

        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            if let games = games {
                self.groups.append(games)
            }
            if let topGrossing = topGrossing {
                self.groups.append(topGrossing)
            }
            if let topFree = topFree {
                self.groups.append(topFree)
            }
            self.collectionView.reloadData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! AppsPageHeader
        header.appHeaderHorizontalController.socialApps = self.socialApps
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsGroupCell
        let appGroup = groups[indexPath.item]
        cell.titleLabel.text = appGroup.feed.title
        cell.appsHorizontalController.appGroup = appGroup
        cell.appsHorizontalController.didSelectHandler = { app in
            let vc = AppDetailController(appId: app.id)
            vc.title = app.name
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
