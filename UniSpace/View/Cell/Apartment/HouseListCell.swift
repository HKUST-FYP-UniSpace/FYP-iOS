//
//  HouseListCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 4/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseListCell: UICollectionViewCell, ImageSettable {

    fileprivate let imageView = StandardImageView(cornerRadius: 5, hasBackground: true)
    let titleLabel = StandardLabel(color: .black, size: 16, isBold: true)
    let priceLabel = StandardLabel(color: .lightGray, size: 14, isBold: false)
    let sizeLabel = StandardLabel(color: .lightGray, size: 14, isBold: false, align: .right)
    let subtitleLabel = StandardLabel(color: .gray, size: 14, isBold: false, numberOfLines: 2)
    let starRatings = StarRatingsView(height: 16)

    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200 / 255.0, green: 199 / 255.0, blue: 204 / 255.0, alpha: 1).cgColor
        return layer
    }()

    private let imageHeight: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.addSublayer(separator)
        let views = [imageView, titleLabel, priceLabel, sizeLabel, subtitleLabel, starRatings]
        for view in views { contentView.addSubview(view) }

        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 4/3).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true

        starRatings.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        starRatings.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true

        priceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: starRatings.bottomAnchor, constant: 5).isActive = true

        sizeLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        sizeLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true

        for view in views { view.sizeToFit() }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let bounds = contentView.bounds
        let height: CGFloat = 0.5
        let left: CGFloat = 15
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
    }

    func setImage(image: UIImage?) {
        imageView.image = image
        imageView.backgroundColor = .clear
    }

}
