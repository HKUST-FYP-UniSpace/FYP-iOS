//
//  TeamMemberCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class TeamMemberCell: UICollectionViewCell, ImageSettable {

    var nameLabel: StandardLabel
    var roleLabel: StandardLabel
    fileprivate var imageView: StandardImageView
    fileprivate let separator: CALayer

    private let imageHeight: CGFloat = 60

    override init(frame: CGRect) {
        nameLabel = StandardLabel(color: .darkGray, size: 18, isBold: true, align: .center)
        roleLabel = StandardLabel(color: .gray, size: 14, isBold: false, align: .center)
        imageView = StandardImageView(cornerRadius: imageHeight / 2, hasBackground: true)
        separator = StandardSeparator()

        super.init(frame: frame)
        setupImageView()
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.layer.addSublayer(separator)
        let views = [nameLabel, roleLabel, imageView]
        for view in views { contentView.addSubview(view) }

        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.narrow).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true

        nameLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -Spacing.narrow).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: Spacing.normal).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.normal).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        roleLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: Spacing.narrow).isActive = true
        roleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        roleLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true

        for view in views { view.sizeToFit() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let bounds = contentView.bounds
        let height: CGFloat = 0.5
        let left: CGFloat = 15
        separator.frame = CGRect(x: left, y: 0, width: bounds.width - left, height: height)
    }


    private func setupImageView() {
        imageView.layer.masksToBounds = true
    }

    func setImage(_ image: UIImage?) {
        imageView.image = image
        imageView.setBackground(hasBackground: image == nil)
    }

}
