//
//  MultipleAppCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/26/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit


class MultipleAppCell: UICollectionViewCell {

    var app: FeedResult! {
        didSet {
            nameLabel.text = app.name
            companyLabel.text = app.artistName
            let url = URL(string: app.artworkUrl100)
            imageView.sd_setImage(with: url)
        }
    }

    let imageView = UIImageView(cornerRadius: 8)

    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))

    let getButton = UIButton(title: "GET")

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.backgroundColor = .purple
        imageView.width(64).height(64)
        getButton.width(80).height(32).style { btn in
            btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
            btn.layer.cornerRadius = 16
        }
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)

        let labelsStackView = VStack(arrangedSubviews: [nameLabel, companyLabel], spacing: 4)

        let stackView = UIStackView(arrangedSubviews: [imageView, labelsStackView, getButton])
        stackView.alignment = .center
        stackView.spacing = 16
        sv(stackView)
        stackView.fillContainer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
