//
//  ButtonCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class ButtonCell: UICollectionViewCell {

    let button = StandardButton(buttonText: "")

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(button)
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
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

}

extension ButtonCell: ListBindable {

    func bindViewModel(_ viewModel: Any) {
//        guard let viewModel = viewModel as? String else { return }
//        ButtonCell.text = viewModel
    }

}
