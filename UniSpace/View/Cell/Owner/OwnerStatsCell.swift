//
//  OwnerStatsCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class OwnerStatsCell: UICollectionViewCell {

    let numberOfViewsLabel = StandardLabel(color: .lightGray, size: 18, isBold: false)
    let statsLabel = StandardLabel(color: .lightGray, size: 18, isBold: false)

    let numberOfViewsTitleLabel = StandardLabel(color: .gray, size: 18, isBold: true)
    let statsTitleLabel = StandardLabel(color: .gray, size: 18, isBold: true)

    fileprivate let separator: CALayer = StandardSeparator()

    private let imageHeight: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.addSublayer(separator)

        let views = [numberOfViewsLabel, statsLabel, numberOfViewsTitleLabel, statsTitleLabel]
        for view in views { contentView.addSubview(view) }

        numberOfViewsTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.normal).isActive = true
        numberOfViewsTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.wide).isActive = true

        numberOfViewsLabel.topAnchor.constraint(equalTo: numberOfViewsTitleLabel.topAnchor).isActive = true
        numberOfViewsLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.wide).isActive = true

        statsTitleLabel.topAnchor.constraint(equalTo: numberOfViewsTitleLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        statsTitleLabel.leftAnchor.constraint(equalTo: numberOfViewsTitleLabel.leftAnchor).isActive = true

        statsLabel.topAnchor.constraint(equalTo: statsTitleLabel.topAnchor).isActive = true
        statsLabel.rightAnchor.constraint(equalTo: numberOfViewsLabel.rightAnchor).isActive = true

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
