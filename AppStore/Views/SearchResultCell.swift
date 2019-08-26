//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/11/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia
import SDWebImage

class SearchResultCell: UICollectionViewCell {

    var app: Result! {
        didSet {
            nameLabel.text = app.trackName
            categoryLabel.text = app.primaryGenreName
            ratingsLabel.text = "\(app.averageUserRating ?? 0.0)"
            let url = URL(string: app.artworkUrl100)
            appIconImageView.sd_setImage(with: url)
            screenshot1View.sd_setImage(with: URL(string: app.screenshotUrls[0]))
            if app.screenshotUrls.count > 1 {
                screenshot2View.sd_setImage(with: URL(string: app.screenshotUrls[1]))
            }
            if app.screenshotUrls.count > 2 {
                screenshot3View.sd_setImage(with: URL(string: app.screenshotUrls[2]))
            }
        }
    }

    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let ratingsLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let getButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("GET", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        btn.layer.cornerRadius = 16
        return btn
    }()

    lazy var screenshot1View = createScreenshotViews()
    lazy var screenshot2View = createScreenshotViews()
    lazy var screenshot3View = createScreenshotViews()

    private func createScreenshotViews() -> UIImageView {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        iv.contentMode = .scaleAspectFill
        return iv
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        let labelsStackView = VStack(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])

        let infoStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        infoStackView.alignment = .center
        infoStackView.spacing = 12

        let screenshotStackView = UIStackView(arrangedSubviews: [screenshot1View, screenshot2View, screenshot3View])
        screenshotStackView.spacing = 12
        screenshotStackView.distribution = .fillEqually

        let overallStackView = VStack(arrangedSubviews: [infoStackView, screenshotStackView], spacing: 16)

        sv(
            overallStackView
        )
        overallStackView.fillContainer(16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
