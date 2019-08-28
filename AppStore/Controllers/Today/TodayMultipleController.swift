//
//  TodayMultipleController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/26/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class TodayMultipleController: BaseListController, UICollectionViewDelegateFlowLayout {

    override var prefersStatusBarHidden: Bool { return true }

    var apps: [FeedResult] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    let closeButton: UIButton = {
        let closeButton = UIButton(type: .system)
        closeButton.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        closeButton.tintColor = .darkGray
        return closeButton
    }()

    private let multipleAppCellId = "multipleAppCellId"
    private let mode: Mode

    enum Mode {
        case small, fullscreen
    }

    init(mode: Mode) {
        self.mode = mode
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: multipleAppCellId)
        if mode == .fullscreen{
            setupCloseButton()
        } else {
            collectionView.isScrollEnabled = false
        }
    }

    func setupCloseButton() {
        view.sv(closeButton)
        closeButton.top(28).right(16).width(44).height(44)
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }

    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mode == .fullscreen ? apps.count : min(4, apps.count)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleAppCellId, for: indexPath) as! MultipleAppCell
        cell.app = apps[indexPath.item]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = apps[indexPath.item].id
        let appDetailVC = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return mode == .fullscreen ? .init(width: view.frame.width - 48, height: 68) : .init(width: view.frame.width, height: (view.frame.height - 3 * spacing) / 4)
    }

    private let spacing: CGFloat = 16
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return mode == .fullscreen ? .init(top: 12, left: 24, bottom: 24, right: 12) : .zero
    }
}
