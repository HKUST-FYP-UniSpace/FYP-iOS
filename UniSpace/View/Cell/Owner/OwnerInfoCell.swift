//
//  OwnerInfoCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class OwnerInfoCell: UICollectionViewCell {

    let addressLabel = StandardLabel(color: .gray, size: 18, isBold: true)
    let priceLabel = StandardLabel(color: .lightGray, size: 18, isBold: false)
    let sizeLabel = StandardLabel(color: .lightGray, size: 18, isBold: false)
    fileprivate let separator: CALayer = StandardSeparator()

    private let imageHeight: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.addSublayer(separator)

        let views = [addressLabel, priceLabel, sizeLabel]
        for view in views { contentView.addSubview(view) }

        addressLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.normal).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.wide).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.wide).isActive = true

        priceLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        priceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: addressLabel.leftAnchor).isActive = true

        sizeLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
        sizeLabel.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: Spacing.wide).isActive = true
        sizeLabel.rightAnchor.constraint(equalTo: addressLabel.rightAnchor).isActive = true

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
