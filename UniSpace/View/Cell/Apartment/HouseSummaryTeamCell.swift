//
//  HouseSummaryTeamCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 4/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseSummaryTeamCell: UICollectionViewCell {

    let titleLabel = StandardLabel(color: .black, size: 18, isBold: true)
    let priceLabel = StandardLabel(color: .lightGray, size: 16, isBold: false)
    let durationLabel = StandardLabel(color: .lightGray, size: 16, isBold: false, align: .right)
    let subtitleLabel = StandardLabel(color: .gray, size: 16, isBold: false, numberOfLines: 2)
    let groupSize = StarRatingsView(height: 16)

    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200 / 255.0, green: 199 / 255.0, blue: 204 / 255.0, alpha: 1).cgColor
        return layer
    }()

    private let seperateDis: CGFloat = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [titleLabel, priceLabel, durationLabel, subtitleLabel, groupSize]
        for view in views { contentView.addSubview(view) }

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: seperateDis).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: seperateDis).isActive = true

        groupSize.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        groupSize.rightAnchor.constraint(equalTo: rightAnchor, constant: -seperateDis).isActive = true

        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: seperateDis).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true

        durationLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
        durationLabel.leftAnchor.constraint(equalTo: centerXAnchor, constant: -seperateDis * 2).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: seperateDis).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true

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

}
