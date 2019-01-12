//
//  HouseSuggestionCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseSuggestionCell: UICollectionViewCell {

    fileprivate let imageView = StandardImageView(cornerRadius: 5)
    fileprivate let activityView = StandardActivityView(cornerRadius: 5)
    let titleLabel = StandardLabel(color: Color.theme, size: 18, isBold: true)
    let subTitleLabel = StandardLabel(color: .gray, size: 16, isBold: false)
    let durationLabel = StandardLabel(color: .lightGray, size: 18, isBold: false, align: .right)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(activityView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(durationLabel)

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        activityView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        activityView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        activityView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        activityView.heightAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: activityView.bottomAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: centerXAnchor).isActive = true

        durationLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        durationLabel.leadingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        imageView.sizeToFit()
        activityView.sizeToFit()
        titleLabel.sizeToFit()
        durationLabel.sizeToFit()
        subTitleLabel.sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        sizeToFit()
    }

    func addShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.7
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