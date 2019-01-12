//
//  TradeSellingItemsCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class TradeSellingItemsCell: UICollectionViewCell {

    fileprivate let imageView = StandardImageView(cornerRadius: 5, hasBackground: true)
    fileprivate let activityView = StandardActivityView()
    let titleLabel = StandardLabel(color: .darkGray, size: 12, isBold: true)
    let priceLabel = StandardLabel(color: .gray, size: 10, isBold: true)
    let viewsLabel = StandardLabel(color: Color.theme, size: 10, isBold: true, align: .right)

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [imageView, activityView, titleLabel, priceLabel, viewsLabel]
        for view in views { contentView.addSubview(view) }

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: centerXAnchor).isActive = true

        viewsLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
        viewsLabel.leadingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        viewsLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

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
