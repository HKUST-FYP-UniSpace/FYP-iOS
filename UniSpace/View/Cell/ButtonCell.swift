//
//  ButtonCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

protocol ButtonCellDelegate: class {
    func buttonCell(pressedButton sender: UIButton)
}

final class ButtonCell: UICollectionViewCell {

    weak var delegate: ButtonCellDelegate?
    let button = StandardButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.wide).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.wide).isActive = true
        button.sizeToFit()
        contentView.sizeToFit()
        contentView.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.cornerRadius = 5
    }

    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }

    @objc func buttonAction(sender: UIButton) {
        delegate?.buttonCell(pressedButton: sender)
    }

}
