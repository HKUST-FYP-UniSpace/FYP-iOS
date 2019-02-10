//
//  NotificationCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class NotificationCell: UICollectionViewCell, ImageSettable {

    var titleLabel: StandardLabel
    var subtitleLabel: StandardLabel
    var timeLabel: StandardLabel
    var imageView: StandardImageView
    fileprivate let separator: CALayer

    private let imageHeight: CGFloat = 60

    override init(frame: CGRect) {
        titleLabel = StandardLabel(color: .darkGray, size: 18, isBold: true)
        subtitleLabel = StandardLabel(color: .gray, size: 14, isBold: false)
        timeLabel = StandardLabel(color: .gray, size: 14, isBold: false, align: .right)
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
        let views = [titleLabel, subtitleLabel, timeLabel, imageView]
        for view in views { contentView.addSubview(view) }

        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.narrow).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true

        titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -Spacing.narrow).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: Spacing.normal).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.normal).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        timeLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: Spacing.narrow).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true

        subtitleLabel.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: Spacing.normal).isActive = true

        for view in views { view.sizeToFit() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let bounds = contentView.bounds
        let height: CGFloat = 0.5
        let left: CGFloat = 15
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
    }


    private func setupImageView() {
        imageView.layer.masksToBounds = true
    }

    func setImage(image: UIImage?) {
        imageView.image = image
        imageView.setBackground(hasBackground: image == nil)
    }

}
