//
//  OwnerTeamsCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class OwnerTeamsCell: UICollectionViewCell {

    let arrangingLabel = StandardLabel(color: .lightGray, size: 18, isBold: false)
    let formingLabel = StandardLabel(color: .lightGray, size: 18, isBold: false)

    let arrangingTitleLabel = StandardLabel(color: .gray, size: 18, isBold: true)
    let formingTitleLabel = StandardLabel(color: .gray, size: 18, isBold: true)
    let ratingsTitleLabel = StandardLabel(color: .gray, size: 18, isBold: true)

    fileprivate let starRatings = StarRatingsView(height: 16)
    fileprivate let separator: CALayer = StandardSeparator()

    private let imageHeight: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.addSublayer(separator)

        let views = [arrangingLabel, formingLabel, arrangingTitleLabel, formingTitleLabel, ratingsTitleLabel, starRatings]
        for view in views { contentView.addSubview(view) }

        arrangingTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.normal).isActive = true
        arrangingTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.wide).isActive = true

        arrangingLabel.topAnchor.constraint(equalTo: arrangingTitleLabel.topAnchor).isActive = true
        arrangingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.wide).isActive = true

        formingTitleLabel.topAnchor.constraint(equalTo: arrangingTitleLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        formingTitleLabel.leftAnchor.constraint(equalTo: arrangingTitleLabel.leftAnchor).isActive = true

        formingLabel.topAnchor.constraint(equalTo: formingTitleLabel.topAnchor).isActive = true
        formingLabel.rightAnchor.constraint(equalTo: arrangingLabel.rightAnchor).isActive = true

        starRatings.topAnchor.constraint(equalTo: formingTitleLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        starRatings.rightAnchor.constraint(equalTo: arrangingLabel.rightAnchor).isActive = true

        ratingsTitleLabel.centerYAnchor.constraint(equalTo: starRatings.centerYAnchor).isActive = true
        ratingsTitleLabel.leftAnchor.constraint(equalTo: arrangingTitleLabel.leftAnchor).isActive = true

        for view in views { view.sizeToFit() }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let bounds = contentView.bounds
        let height: CGFloat = 0.5
        let left: CGFloat = 15
        separator.frame = CGRect(x: left, y: 0, width: bounds.width - left, height: height)
    }

    func setStarRating(rating: Int) {
        starRatings.setStarRating(rating: rating)
    }

}
