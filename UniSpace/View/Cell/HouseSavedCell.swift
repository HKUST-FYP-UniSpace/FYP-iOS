//
//  HouseSavedCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseSavedCell: UICollectionViewCell {

    let titleLabel = StandardLabel(color: .darkGray, size: 12, isBold: true)
    let priceLabel = StandardLabel(color: .gray, size: 10, isBold: true)
    let sizeLabel = StandardLabel(color: .gray, size: 10, isBold: true, align: .right)
    fileprivate let imageView = StandardImageView(cornerRadius: 5, hasBackground: true)
    fileprivate let activityView = StandardActivityView()
    fileprivate let star1ImageView = StandardImageView()
    fileprivate let star2ImageView = StandardImageView()
    fileprivate let star3ImageView = StandardImageView()
    fileprivate let star4ImageView = StandardImageView()
    fileprivate let star5ImageView = StandardImageView()
    private let verticalSpacing: CGFloat = 5

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [imageView, activityView, star1ImageView, star2ImageView, star3ImageView, star4ImageView, star5ImageView, titleLabel, priceLabel, sizeLabel]
        for view in views { contentView.addSubview(view) }

        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: verticalSpacing).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        setStarAnchors(starView: star1ImageView, topView: titleLabel, leftView: nil)
        setStarAnchors(starView: star2ImageView, topView: titleLabel, leftView: star1ImageView)
        setStarAnchors(starView: star3ImageView, topView: titleLabel, leftView: star2ImageView)
        setStarAnchors(starView: star4ImageView, topView: titleLabel, leftView: star3ImageView)
        setStarAnchors(starView: star5ImageView, topView: titleLabel, leftView: star4ImageView)

        priceLabel.topAnchor.constraint(equalTo: star1ImageView.bottomAnchor, constant: verticalSpacing).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: centerXAnchor).isActive = true

        sizeLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
        sizeLabel.leadingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sizeLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

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

    func setStarRating(rating: Int) {
        let stars = [star1ImageView, star2ImageView, star3ImageView, star4ImageView, star5ImageView]
        for (index, star) in stars.enumerated() {
            star.image = index < rating ? UIImage(named: "Star") : UIImage(named: "Star_gray")
        }
    }

    private func setStarAnchors(starView: UIView, topView: UIView, leftView: UIView?) {
        if let leftView = leftView {
            starView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 2).isActive = true
        } else {
            starView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        }
        starView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: verticalSpacing).isActive = true
        starView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        starView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }

}
