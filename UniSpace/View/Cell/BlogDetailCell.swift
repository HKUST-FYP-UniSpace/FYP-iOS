//
//  BlogDetailCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 10/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class BlogDetailCell: UICollectionViewCell, ImageSettable {

    fileprivate let imageView = StandardImageView()
    fileprivate let activityView = StandardActivityView()
    let titleLabel = StandardLabel(color: .gray, size: 20, isBold: true)
    let subtitleLabel = StandardLabel(color: .black, size: 34, isBold: true, numberOfLines: 2)
    let detailLabel = StandardLabel(color: .gray, size: 20, isBold: false, numberOfLines: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [imageView, activityView, titleLabel, subtitleLabel, detailLabel]
        for view in views { contentView.addSubview(view) }

        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: Spacing.wide).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: Spacing.wide).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -Spacing.wide).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true

        detailLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Spacing.wide).isActive = true
        detailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.wide).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.wide).isActive = true

        for view in views { view.sizeToFit() }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        sizeToFit()
    }

    func setImage(image: UIImage?) {
        imageView.image = image
        if image != nil {
            activityView.stopAnimating()
        } else {
            activityView.startAnimating()
        }
    }

}
