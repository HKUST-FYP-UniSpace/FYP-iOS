//
//  TeamSummaryCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class TeamSummaryCell: UICollectionViewCell {

    let label = StandardLabel(color: .darkGray, size: 16, isBold: false, numberOfLines: 4)
    fileprivate let topSeparator: CALayer = StandardSeparator()
    fileprivate let bottomSeparator: CALayer = StandardSeparator()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.addSublayer(topSeparator)
        contentView.layer.addSublayer(bottomSeparator)
        contentView.addSubview(label)

        label.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.normal).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.normal).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.normal).isActive = true

        label.sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let bounds = contentView.bounds
        let height: CGFloat = 0.5
        let left: CGFloat = 15
        topSeparator.frame = CGRect(x: left, y: 0, width: bounds.width - left, height: height)
        bottomSeparator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
    }

}
