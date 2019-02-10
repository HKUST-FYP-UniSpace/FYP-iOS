//
//  SectionHeaderCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 7/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class SectionHeaderCell: UICollectionViewCell {

    let titleLabel = StandardLabel(color: .gray, size: 12, isBold: false)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.normal).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.normal).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        titleLabel.sizeToFit()
        contentView.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

