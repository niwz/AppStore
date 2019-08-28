//
//  TodayMultipleCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/26/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class TodayMultipleCell: BaseTodayCell {

    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            multipleAppsController.apps = todayItem.apps
        }
    }

    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28), numberOfLines: 2)
    let multipleAppsController = TodayMultipleController(mode: .small)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        multipleAppsController.view.backgroundColor = .red
        let stackView = VStack(arrangedSubviews: [categoryLabel, titleLabel, multipleAppsController.view], spacing: 12)
        sv(stackView)
        stackView.fillContainer(24)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
