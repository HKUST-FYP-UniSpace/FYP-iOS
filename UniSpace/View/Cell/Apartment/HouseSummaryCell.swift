//
//  HouseSummaryCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 4/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseSummaryCell: UICollectionViewCell {

    let titleLabel = StandardLabel(color: .darkGray, size: 18, isBold: true)
    let priceLabel = StandardLabel(color: .lightGray, size: 16, isBold: false)
    let sizeLabel = StandardLabel(color: .lightGray, size: 16, isBold: false, align: .right)
    let subtitleLabel = StandardLabel(color: .gray, size: 16, isBold: false, numberOfLines: 2)
    fileprivate let starRatings = StarRatingsView(height: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [titleLabel, priceLabel, sizeLabel, subtitleLabel, starRatings]
        for view in views { contentView.addSubview(view) }

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.normal).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.normal).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.normal).isActive = true

        starRatings.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        starRatings.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true

        priceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: starRatings.bottomAnchor, constant: Spacing.normal).isActive = true

        sizeLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        sizeLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true

        for view in views { view.sizeToFit() }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setStarRating(rating: Double) {
        starRatings.setStarRating(rating: rating)
    }

}
