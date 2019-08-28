//
//  TodayController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/25/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout{

    var startingFrame: CGRect?
    var fullscreenController: AppFullscreenController!
    var items = [TodayItem]()
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        return aiv
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.sv(activityIndicatorView)
        activityIndicatorView.fillContainer()
        navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        fetchData()
    }

    private func fetchData() {

        let dispatchGroup = DispatchGroup()
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?

        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            topGrossingGroup = appGroup
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            gamesGroup = appGroup
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            self.items = [
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, apps: []),
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed.results ?? [])]
            self.collectionView.reloadData()

        }


    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellId = items[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        if let cell = cell as? BaseTodayCell {
            cell.todayItem = items[indexPath.item]
        }

        (cell as? TodayMultipleCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))

        return cell
    }

    @objc private func handleMultipleAppsTap(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        var superview = collectionView?.superview
        while superview != nil {
            if let cell = superview as? TodayMultipleCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                let apps = self.items[indexPath.item].apps
                let fullController = TodayMultipleController(mode: .fullscreen)
                fullController.apps = apps
                present(fullController, animated: true)
                return
            }
            superview = superview?.superview

        }
    }

    static let cellHeight: CGFloat = 500

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if items[indexPath.item].cellType == .multiple {
            let fullController = TodayMultipleController(mode: .fullscreen)
            fullController.apps = items[indexPath.item].apps
            present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
            return
        }

        let fullscreenController = AppFullscreenController()
        self.fullscreenController = fullscreenController
        fullscreenController.todayItem = items[indexPath.item]
        fullscreenController.dismissHandler = { self.handleDismissPopupView() }

        addChild(fullscreenController)
        let fullscreenView = fullscreenController.view!
        fullscreenView.layer.cornerRadius = 16
        view.sv(fullscreenView)

        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }

        self.startingFrame = startingFrame
        fullscreenView.top(startingFrame.origin.y)
            .left(startingFrame.origin.x)
            .width(startingFrame.width)
            .height(startingFrame.height)
        view.layoutIfNeeded()

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            collectionView.isUserInteractionEnabled = false
            fullscreenView.topConstraint?.constant = 0
            fullscreenView.leftConstraint?.constant = 0
            fullscreenView.widthConstraint?.constant = self.view.frame.width
            fullscreenView.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)

            guard let cell = self.fullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.stackViewTopConstraint.constant = 48
            cell.layoutIfNeeded()
        }, completion: nil)
    }

    func handleDismissPopupView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.fullscreenController.closeButton.alpha = 0
            self.fullscreenController.tableView.contentOffset = .zero
            guard let startingFrame = self.startingFrame else { return }
            self.fullscreenController.view.topConstraint?.constant = startingFrame.origin.y
            self.fullscreenController.view.leftConstraint?.constant = startingFrame.origin.x
            self.fullscreenController.view.widthConstraint?.constant = startingFrame.width
            self.fullscreenController.view.heightConstraint?.constant = startingFrame.height
            self.fullscreenController.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = .identity
            guard let cell = self.fullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.stackViewTopConstraint.constant = 24
            cell.layoutIfNeeded()
        }, completion: { _ in
            self.fullscreenController.view.removeFromSuperview()
            self.fullscreenController?.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
}
