//
//  HouseReviewCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 7/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseReviewCell: UICollectionViewCell, ImageSettable {

    private let imageHeight: CGFloat = 60

    fileprivate let imageView: StandardImageView
    fileprivate let reviewBackgroundView = StandardImageView(cornerRadius: 5)
    fileprivate let ownerBackgroundView = StandardImageView(cornerRadius: 5)
    fileprivate let starRatings = StarRatingsView(height: 16)

    fileprivate let ownerTitleLabel = StandardLabel(color: .black, size: 16, isBold: true)
    fileprivate let ownerCommentLabel = StandardLabel(color: .gray, size: 16, isBold: false, numberOfLines: 5)

    let titleLabel = StandardLabel(color: .black, size: 16, isBold: true)
    let dateLabel = StandardLabel(color: .lightGray, size: 16, isBold: false, align: .right)
    let usernameLabel = StandardLabel(color: .lightGray, size: 16, isBold: false, align: .right)
    let detailLabel = StandardLabel(color: .gray, size: 16, isBold: false, numberOfLines: 5)

    override init(frame: CGRect) {
        imageView = StandardImageView(cornerRadius: imageHeight / 2, hasBackground: true)
        super.init(frame: frame)
        let views = [imageView, reviewBackgroundView, ownerBackgroundView, starRatings, titleLabel, dateLabel, usernameLabel, detailLabel, ownerTitleLabel, ownerCommentLabel]
        for view in views { contentView.addSubview(view) }

        dateLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.normal).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.normal).isActive = true

        titleLabel.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.normal).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: dateLabel.leftAnchor, constant: -Spacing.normal).isActive = true

        starRatings.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.narrow).isActive = true
        starRatings.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true

        usernameLabel.centerYAnchor.constraint(equalTo: starRatings.centerYAnchor).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: dateLabel.rightAnchor).isActive = true

        detailLabel.topAnchor.constraint(equalTo: starRatings.bottomAnchor, constant: Spacing.normal).isActive = true
        detailLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: dateLabel.rightAnchor).isActive = true

        reviewBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        reviewBackgroundView.bottomAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        reviewBackgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        reviewBackgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        imageView.topAnchor.constraint(equalTo: reviewBackgroundView.bottomAnchor, constant: Spacing.wide).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true

        ownerBackgroundView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        ownerBackgroundView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: Spacing.normal).isActive = true
        ownerBackgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        ownerTitleLabel.topAnchor.constraint(equalTo: ownerBackgroundView.topAnchor, constant: Spacing.normal).isActive = true
        ownerTitleLabel.leftAnchor.constraint(equalTo: ownerBackgroundView.leftAnchor, constant: Spacing.normal).isActive = true
        ownerTitleLabel.rightAnchor.constraint(equalTo: ownerBackgroundView.rightAnchor, constant: -Spacing.normal).isActive = true

        ownerCommentLabel.topAnchor.constraint(equalTo: ownerTitleLabel.bottomAnchor, constant: Spacing.narrow).isActive = true
        ownerCommentLabel.leftAnchor.constraint(equalTo: ownerTitleLabel.leftAnchor).isActive = true
        ownerCommentLabel.rightAnchor.constraint(equalTo: ownerTitleLabel.rightAnchor).isActive = true

        ownerBackgroundView.bottomAnchor.constraint(equalTo: ownerCommentLabel.bottomAnchor, constant: Spacing.normal).isActive = true

        for view in views { view.sizeToFit() }
        self.clipsToBounds = true
        self.backgroundColor = .white
        reviewBackgroundView.backgroundColor = Color.Option.background
        ownerBackgroundView.backgroundColor = Color.Option.background
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        sizeToFit()
    }

    func setImage(_ image: UIImage?) {
        imageView.image = image
        imageView.setBackground(hasBackground: image == nil)
    }

    func setStarRating(rating: Double) {
        starRatings.setStarRating(rating: rating)
    }

    func setOwnerComment(_ comment: String, role: UserType) {
        hideOwnerComment(false)
        ownerTitleLabel.text = "Owner Responses"
        guard comment.isEmpty else {
            ownerCommentLabel.text = comment
            return
        }

        switch role {
        case .Tenant:
            hideOwnerComment(true)

        case .Owner:
            ownerTitleLabel.text = "Reply Now"
            ownerCommentLabel.text = nil
        }
    }

    private func hideOwnerComment(_ hidden: Bool) {
        imageView.isHidden = hidden
        ownerTitleLabel.isHidden = hidden
        ownerCommentLabel.isHidden = hidden
        ownerBackgroundView.isHidden = hidden
    }

}
