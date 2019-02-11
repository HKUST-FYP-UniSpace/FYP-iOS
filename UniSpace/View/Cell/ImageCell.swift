//
//  ImageCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 10/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class ImageCell: UICollectionViewCell, ImageSettable {

    fileprivate let imageView = StandardImageView(hasBackground: true)
    fileprivate let activityView = StandardActivityView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let views = [imageView, activityView]
        for view in views { contentView.addSubview(view) }

        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75).isActive = true

        activityView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        for view in views { view.sizeToFit() }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
