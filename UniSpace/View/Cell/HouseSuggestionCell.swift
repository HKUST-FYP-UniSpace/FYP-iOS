//
//  HouseSuggestionCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class HouseSuggestionCell: UICollectionViewCell {

    fileprivate let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return view
    }()

    fileprivate let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.startAnimating()
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 34)
        return label
    }()

    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .gray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(activityView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = contentView.bounds
        activityView.center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        imageView.frame = bounds
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
