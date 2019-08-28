//
//  AppFullscreenController.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/25/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class AppFullscreenController: UIViewController {

    var todayItem: TodayItem?

    let tableView = UITableView()
    let closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close_button"), for: .normal)
        btn.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return btn
    }()
    var dismissHandler: (()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true
        setupViews()
        setupTableView()
    }

    func setupViews() {
        view.backgroundColor = .white
        view.sv(tableView, closeButton)
        tableView.fillContainer()
        tableView.contentInsetAdjustmentBehavior = .never
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
        closeButton.right(0).width(80).height(40)
        closeButton.Top == view.safeAreaLayoutGuide.Top + 24
    }

    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }

    @objc func closeButtonTapped() {
        dismissHandler?()
    }
}

extension AppFullscreenController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = AppFullscreenHeaderCell()
            cell.todayCell.todayItem = todayItem
            cell.todayCell.layer.cornerRadius = 0
            cell.clipsToBounds = true
            cell.selectionStyle = .none
            return cell
        }
        let cell = AppFullscreenDescriptionCell()
        cell.selectionStyle = .none
        return cell
    }
}

extension AppFullscreenController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayController.cellHeight
        }
        return UITableView.automaticDimension
    }
}
