//
//  BlogCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class BlogCell: UICollectionViewCell, ImageSettable {

    fileprivate let imageView = StandardImageView()
    fileprivate let activityView = StandardActivityView()
    let titleLabel = StandardLabel(color: .gray, size: 20, isBold: true)
    let subtitleLabel = StandardLabel(color: .black, size: 34, isBold: true, numberOfLines: 2)

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [imageView, activityView, titleLabel, subtitleLabel]
        for view in views { contentView.addSubview(view) }

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        for view in views { view.sizeToFit() }
        self.clipsToBounds = true
        self.layer.masksToBounds = false
//        self.layer.cornerRadius = 10
//        self.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.backgroundColor = .white
        addShadow()
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

        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
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
