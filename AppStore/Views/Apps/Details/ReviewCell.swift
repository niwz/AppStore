//
//  ReviewCell.swift
//  AppStore
//
//  Created by Nicholas Wong on 8/24/19.
//  Copyright © 2019 Nicholas Wong. All rights reserved.
//

import UIKit
import Stevia

class ReviewCell: UICollectionViewCell {

    var review: Entry? {
        didSet {
            titleLabel.text = review?.title.label
            authorLabel.text = review?.author.name.label
            reviewLabel.text = review?.content.label
            for (index, view) in starsStackView.arrangedSubviews.enumerated() {
                if let ratingInt = Int(review?.rating.label ?? "0") {
                    view.alpha = index >= ratingInt ? 0 : 1
                }
            }
        }
    }

    let titleLabel = UILabel(text: "Title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let reviewLabel = UILabel(text: "Review body\nReview body\nReview body", font: .systemFont(ofSize: 16), numberOfLines: 5)
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({ (_) in
            let star = UIImageView(image: #imageLiteral(resourceName: "star"))
            star.size(24)
            arrangedSubviews.append(star)
        })
        arrangedSubviews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(displayP3Red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        layer.cornerRadius = 16
        let titleAuthorStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8)
        let stackView = VStack(arrangedSubviews: [
            titleAuthorStackView,
            starsStackView,
            reviewLabel], spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        sv(stackView)
        stackView.fillHorizontally(m: 16).top(16)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
