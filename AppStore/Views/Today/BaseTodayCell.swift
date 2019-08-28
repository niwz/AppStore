//
//  BaseTodayCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/26/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
    var todayItem: TodayItem!

    override var isHighlighted: Bool {
        didSet {
            var transform: CGAffineTransform = .identity
            if isHighlighted {
                transform = .init(scaleX: 0.9, y: 0.9)
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.transform = transform
            }, completion: nil)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundView = UIView()
        sv(self.backgroundView!)
        self.backgroundView?.fillContainer()
        self.backgroundView?.backgroundColor = .white
        self.backgroundView?.layer.cornerRadius = 16
        self.backgroundView?.layer.shadowOpacity = 0.1
        self.backgroundView?.layer.shadowRadius = 10
        self.backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
        self.backgroundView?.layer.shouldRasterize = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
