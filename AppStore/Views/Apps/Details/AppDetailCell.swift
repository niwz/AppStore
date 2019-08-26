//
//  AppDetailCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/23/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class AppDetailCell: UICollectionViewCell {

    let appIconImageView = UIImageView(cornerRadius: 16)

    let nameLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)

    let priceButton: UIButton = {
        let priceButton = UIButton()
        priceButton.width(80)
        priceButton.layer.cornerRadius = 16
        priceButton.height(32)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        priceButton.backgroundColor = .blue
        return priceButton
    }()

    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))

    let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 18), numberOfLines: 0)

    var app: Result! {
        didSet {
            appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            nameLabel.text = app?.trackName
            priceButton.setTitle(app?.formattedPrice, for: .normal)
            releaseNotesLabel.text = app?.releaseNotes
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        appIconImageView.size(140)
        let nameAndPriceStack = VStack(arrangedSubviews: [nameLabel, priceButton], spacing: 12)
        nameAndPriceStack.alignment = .leading
        let stackView = VStack(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                nameAndPriceStack], customSpacing: 20),
            whatsNewLabel,
            releaseNotesLabel
            ], spacing: 16)
        sv(stackView)
        stackView.fillContainer(20)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
