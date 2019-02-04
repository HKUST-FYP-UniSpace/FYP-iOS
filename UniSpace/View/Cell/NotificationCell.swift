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
    var subTitleLabel: StandardLabel
    var timeLabel: StandardLabel
    var imageView: StandardImageView

    let separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200 / 255.0, green: 199 / 255.0, blue: 204 / 255.0, alpha: 1).cgColor
        return layer
    }()

    private let imageHeight: CGFloat = 60

    override init(frame: CGRect) {
        titleLabel = StandardLabel(color: .darkGray, size: 18, isBold: true)
        subTitleLabel = StandardLabel(color: .gray, size: 14, isBold: false)
        timeLabel = StandardLabel(color: .gray, size: 14, isBold: false, align: .right)
        imageView = StandardImageView(cornerRadius: imageHeight / 2, hasBackground: true)

        super.init(frame: frame)
        setupImageView()
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.layer.addSublayer(separator)
        let views = [titleLabel, subTitleLabel, timeLabel, imageView]
        for view in views { contentView.addSubview(view) }

        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true

        titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        timeLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 5).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true

        subTitleLabel.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subTitleLabel.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: -10).isActive = true

        for view in views { view.sizeToFit() }
        titleLabel.lineBreakMode = .byTruncatingTail
        subTitleLabel.lineBreakMode = .byTruncatingTail
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
//        imageView.layer.borderWidth = 2
//        imageView.layer.borderColor = Color.theme.cgColor
    }

    func setImage(image: UIImage?) {
        imageView.image = image
        imageView.backgroundColor = .clear
    }

}
