//
//  HouseSummaryCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 4/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseSummaryCell: UICollectionViewCell, ImageSettable {

    fileprivate let imageView = StandardImageView(cornerRadius: 5, hasBackground: true)
    fileprivate let activityView = StandardActivityView(cornerRadius: 5)
    let titleLabel = StandardLabel(color: .black, size: 18, isBold: true)
    let priceLabel = StandardLabel(color: .lightGray, size: 16, isBold: false)
    let sizeLabel = StandardLabel(color: .lightGray, size: 16, isBold: false, align: .right)
    let subtitleLabel = StandardLabel(color: .gray, size: 16, isBold: false, numberOfLines: 2)
    let starRatings = StarRatingsView(height: 16)

    private let seperateDis: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [imageView, titleLabel, priceLabel, sizeLabel, subtitleLabel, starRatings]
        for view in views { contentView.addSubview(view) }

        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: seperateDis).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: seperateDis).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -seperateDis).isActive = true

        starRatings.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: seperateDis).isActive = true
        starRatings.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true

        priceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: starRatings.bottomAnchor, constant: seperateDis).isActive = true

        sizeLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        sizeLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: seperateDis).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true

        for view in views { view.sizeToFit() }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setImage(image: UIImage?) {
        imageView.image = image
        imageView.backgroundColor = .clear
    }

}
