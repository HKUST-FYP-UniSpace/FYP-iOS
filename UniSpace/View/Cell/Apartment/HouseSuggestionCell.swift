//
//  HouseSuggestionCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseSuggestionCell: UICollectionViewCell, ImageSettable {

    fileprivate let imageView = StandardImageView(cornerRadius: 5, hasBackground: true)
    fileprivate let activityView = StandardActivityView()
    fileprivate let groupSize = GroupSizeView(height: 36)
    let titleLabel = StandardLabel(color: Color.theme, size: 18, isBold: true)
    let subtitleLabel = StandardLabel(color: .gray, size: 16, isBold: false)
    let durationLabel = StandardLabel(color: .lightGray, size: 18, isBold: false, align: .right)

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [imageView, activityView, groupSize, titleLabel, subtitleLabel, durationLabel]
        for view in views { contentView.addSubview(view) }

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        groupSize.topAnchor.constraint(equalTo: imageView.topAnchor, constant: Spacing.normal).isActive = true
        groupSize.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -Spacing.normal).isActive = true

        durationLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Spacing.normal).isActive = true
        durationLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: durationLabel.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: Spacing.normal).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        for view in views { view.sizeToFit() }
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

    func setImage(_ image: UIImage?) {
        imageView.image = image
        if image != nil {
            activityView.stopAnimating()
        } else {
            activityView.startAnimating()
        }
    }

    func createGroup(occupiedCount: Int, size: Int) {
        groupSize.create(occupiedCount: occupiedCount, size: size)
    }

}
