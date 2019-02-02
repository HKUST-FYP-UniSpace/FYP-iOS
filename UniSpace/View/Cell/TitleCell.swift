//
//  TitleCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class TitleCell: UICollectionViewCell, ImageSettable {

    fileprivate static let titleLabelInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    fileprivate static let subTitleLabelInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    fileprivate let imageView = StandardImageView()
    let titleLabel = StandardLabel(color: .black, size: 34, isBold: true)
    let subTitleLabel = StandardLabel(color: .gray, size: 20, isBold: true)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(imageView)

        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true

        subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true

        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true

        titleLabel.sizeToFit()
        subTitleLabel.sizeToFit()
        imageView.sizeToFit()
        contentView.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame.inset(by: TitleCell.titleLabelInsets)
        subTitleLabel.frame.inset(by: TitleCell.subTitleLabelInsets)
    }

    override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = UIColor(white: isHighlighted ? 0.9 : 1, alpha: 1)
        }
    }

    func setImage(image: UIImage?) {
        imageView.image = image
        imageView.backgroundColor = .clear
    }

}

extension TitleCell: ListBindable {

    func bindViewModel(_ viewModel: Any) {
        guard let viewModel = viewModel as? String else { return }
        titleLabel.text = viewModel
    }

}
