//
//  HouseSummaryCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 4/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseSummaryCell: UICollectionViewCell, ImageSettable {

    fileprivate let imageView = StandardImageView(hasBackground: true)
    fileprivate let activityView = StandardActivityView()
    let titleLabel = StandardLabel(color: .darkGray, size: 18, isBold: true)
    let priceLabel = StandardLabel(color: .lightGray, size: 16, isBold: false)
    let sizeLabel = StandardLabel(color: .lightGray, size: 16, isBold: false, align: .right)
    let subtitleLabel = StandardLabel(color: .gray, size: 16, isBold: false, numberOfLines: 2)
    fileprivate let starRatings = StarRatingsView(height: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [imageView, activityView, titleLabel, priceLabel, sizeLabel, subtitleLabel, starRatings]
        for view in views { contentView.addSubview(view) }

        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Spacing.normal).isActive = true
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

    func setImage(image: UIImage?) {
        imageView.image = image
        if image != nil {
            activityView.stopAnimating()
        } else {
            activityView.startAnimating()
        }
    }

    func setStarRating(rating: Int) {
        starRatings.setStarRating(rating: rating)
    }

}
