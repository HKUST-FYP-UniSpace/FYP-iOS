//
//  TradeFeaturedCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class TradeFeaturedCell: UICollectionViewCell {

    fileprivate let imageView = StandardImageView()
    fileprivate let activityView = StandardActivityView()
    let titleLabel = StandardLabel(color: .darkGray, size: 12, isBold: true)
    let priceLabel = StandardLabel(color: .gray, size: 10, isBold: true)
    let statusLabel = StandardLabel(color: Color.theme, size: 10, isBold: true, align: .right)
    let detailLabel = StandardLabel(color: .gray, size: 10, isBold: true, numberOfLines: 2)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(activityView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(detailLabel)

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        activityView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        activityView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        activityView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        activityView.heightAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: activityView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: centerXAnchor).isActive = true

        statusLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        detailLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        imageView.sizeToFit()
        activityView.sizeToFit()
        titleLabel.sizeToFit()
        priceLabel.sizeToFit()
        statusLabel.sizeToFit()
        detailLabel.sizeToFit()
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
