//
//  AppsHeaderCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/18/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class AppsHeaderCell: UICollectionViewCell {

    var app: SocialApp? {
        didSet {
            titleLabel.text = app?.tagline
            companyLabel.text = app?.name
            imageView.sd_setImage(with: URL(string: app?.imageUrl ?? ""))
        }
    }

    let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
    let imageView = UIImageView(cornerRadius: 8)

    override init(frame: CGRect) {
        super.init(frame: frame)
        companyLabel.textColor = .blue 
        titleLabel.numberOfLines = 2
        let stackView = UIStackView(arrangedSubviews: [companyLabel, titleLabel, imageView])
        stackView.spacing = 12
        stackView.axis = .vertical
        sv(stackView)
        stackView.fillHorizontally().bottom(0).top(16)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
