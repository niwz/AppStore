//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/11/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    private let reuseIdentifier = "Cell"
    private var appResults = [Result]()
    var timer: Timer?
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.hidesWhenStopped = true
        return aiv
    }()

    private let searchController = UISearchController(searchResultsController: nil)
    private let searchPromptLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.addSubview(searchPromptLabel)
        searchPromptLabel.fillContainer(50)
        view.sv(activityIndicatorView)
        activityIndicatorView.fillContainer()
        setupSearchbar()
    }

    private func setupSearchbar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.fetchItunesApps(searchText)
        })
    }

    private func fetchItunesApps(_ searchTerm: String) {
        activityIndicatorView.startAnimating()
        Service.shared.fetchApps(searchTerm: searchTerm) { (results, error) in
            if let error = error {
                print("Failed to fetch apps: ", error)
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
                return
            }
            self.appResults = results?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.activityIndicatorView.stopAnimating()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchPromptLabel.isHidden = appResults.count != 0
        return appResults.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
        let appResult = appResults[indexPath.item]
        cell.app = appResult
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = String(appResults[indexPath.item].trackId)
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
}
