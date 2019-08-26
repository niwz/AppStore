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

    let cellId = "CellID"
    var startingFrame: CGRect?
    var fullscreenController: AppFullscreenController!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 450)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullscreenController = AppFullscreenController()
        self.fullscreenController = fullscreenController
        fullscreenController.dismissHandler = { self.handleDismissPopupView() }
        addChild(fullscreenController)
        let fullscreenView = fullscreenController.view!
        view.sv(fullscreenView)
//        fullscreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissPopupView)))
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        fullscreenView.top(startingFrame.origin.y)
            .left(startingFrame.origin.x)
            .width(startingFrame.width)
            .height(startingFrame.height)
        view.layoutIfNeeded()
        fullscreenView.layer.cornerRadius = 16
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            fullscreenView.topConstraint?.constant = 0
            fullscreenView.leftConstraint?.constant = 0
            fullscreenView.widthConstraint?.constant = self.view.frame.width
            fullscreenView.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
    }

    func handleDismissPopupView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.fullscreenController.tableView.contentOffset = .zero
            guard let startingFrame = self.startingFrame else { return }
            self.fullscreenController.view.topConstraint?.constant = startingFrame.origin.y
            self.fullscreenController.view.leftConstraint?.constant = startingFrame.origin.x
            self.fullscreenController.view.widthConstraint?.constant = startingFrame.width
            self.fullscreenController.view.heightConstraint?.constant = startingFrame.height
            self.fullscreenController.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = .identity
        }, completion: { _ in
            self.fullscreenController.view.removeFromSuperview()
            self.fullscreenController?.removeFromParent()
        })
    }
}
