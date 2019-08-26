//
//  TodayImageContainerView.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/26/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit

class TodayImageContainerView: UIView {
    let imageView = UIImageView()
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sv(imageView)
        imageView.centerInContainer().size(240)
        imageView.contentMode = .scaleAspectFill
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension TodayImageContainerView {
    convenience init(image: UIImage) {
        self.init(frame: .zero)
        self.image = image
    }
}
