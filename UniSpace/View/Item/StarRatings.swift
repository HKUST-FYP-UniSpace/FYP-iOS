//
//  StarRatings.swift
//  UniSpace
//
//  Created by KiKan Ng on 4/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class StarRatings: UIView {

    fileprivate let star1ImageView = StandardImageView()
    fileprivate let star2ImageView = StandardImageView()
    fileprivate let star3ImageView = StandardImageView()
    fileprivate let star4ImageView = StandardImageView()
    fileprivate let star5ImageView = StandardImageView()

    private var height: CGFloat

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(height: CGFloat) {
        self.height = height
        super.init(frame: CGRect.zero)
        let views = [star1ImageView, star2ImageView, star3ImageView, star4ImageView, star5ImageView]
        for view in views { addSubview(view) }
        setStarAnchors(starView: star1ImageView, leftView: nil)
        setStarAnchors(starView: star2ImageView, leftView: star1ImageView)
        setStarAnchors(starView: star3ImageView, leftView: star2ImageView)
        setStarAnchors(starView: star4ImageView, leftView: star3ImageView)
        setStarAnchors(starView: star5ImageView, leftView: star4ImageView)
        for view in views { view.sizeToFit() }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: star1ImageView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: star5ImageView.trailingAnchor).isActive = true
        sizeToFit()
    }

    func setStarRating(rating: Int) {
        let stars = [star1ImageView, star2ImageView, star3ImageView, star4ImageView, star5ImageView]
        for (index, star) in stars.enumerated() {
            star.image = index < rating ? UIImage(named: "Star") : UIImage(named: "Star_gray")
        }
    }

    private func setStarAnchors(starView: UIView, leftView: UIView?) {
        if let leftView = leftView {
            starView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: 2).isActive = true
        } else {
            starView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        }
        starView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        starView.widthAnchor.constraint(equalToConstant: height).isActive = true
        starView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

}
