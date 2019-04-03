//
//  HouseDetailCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseDetailCell: UICollectionViewCell {

    let roomsLabel = StandardLabel(color: .gray, size: 16, isBold: true)
    let bedsLabel = StandardLabel(color: .gray, size: 16, isBold: true)
    let toiletsLabel = StandardLabel(color: .gray, size: 16, isBold: true)

    let roomsTitleLabel = StandardLabel(color: .gray, size: 16, isBold: false)
    let bedsTitleLabel = StandardLabel(color: .gray, size: 16, isBold: false)
    let toiletsTitleLabel = StandardLabel(color: .gray, size: 16, isBold: false)

    fileprivate let separator: CALayer = StandardSeparator()

    private let imageHeight: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.addSublayer(separator)

        let views = [roomsLabel, bedsLabel, toiletsLabel, roomsTitleLabel, bedsTitleLabel, toiletsTitleLabel]
        for view in views { contentView.addSubview(view) }

        roomsTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.normal).isActive = true
        roomsTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.normal).isActive = true

        roomsLabel.topAnchor.constraint(equalTo: roomsTitleLabel.topAnchor).isActive = true
        roomsLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.wide).isActive = true

        bedsTitleLabel.topAnchor.constraint(equalTo: roomsTitleLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        bedsTitleLabel.leftAnchor.constraint(equalTo: roomsTitleLabel.leftAnchor).isActive = true

        bedsLabel.topAnchor.constraint(equalTo: bedsTitleLabel.topAnchor).isActive = true
        bedsLabel.rightAnchor.constraint(equalTo: roomsLabel.rightAnchor).isActive = true

        toiletsTitleLabel.topAnchor.constraint(equalTo: bedsTitleLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        toiletsTitleLabel.leftAnchor.constraint(equalTo: bedsTitleLabel.leftAnchor).isActive = true

        toiletsLabel.topAnchor.constraint(equalTo: toiletsTitleLabel.topAnchor).isActive = true
        toiletsLabel.rightAnchor.constraint(equalTo: roomsLabel.rightAnchor).isActive = true

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
