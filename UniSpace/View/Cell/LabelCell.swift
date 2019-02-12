//
//  LabelCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class LabelCell: UICollectionViewCell {

    let label = StandardLabel(color: Color.theme, size: 20, isBold: false)
    fileprivate let separator: CALayer

    override init(frame: CGRect) {
        separator = StandardSeparator()
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.layer.addSublayer(separator)
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.wide).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.wide).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.sizeToFit()

        self.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let bounds = contentView.bounds
        let height: CGFloat = 0.5
        let left: CGFloat = Spacing.wide
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
    }

    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }

}

extension LabelCell: ListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? String else { return }
        label.text = viewModel
    }

}
