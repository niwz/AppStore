//
//  AppFullscreenHeaderCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/25/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class AppFullscreenHeaderCell: UITableViewCell {

    let todayCell = TodayCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sv(todayCell)
        todayCell.centerInContainer().size(250)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
