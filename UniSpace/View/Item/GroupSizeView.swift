//
//  GroupSizeView.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class GroupSizeView: UIView {

    private let width: CGFloat = 8
    private let height: CGFloat
    private let first: StandardImageView
    private var views: [StandardImageView] = []

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(height: CGFloat) {
        self.height = height
        first = StandardImageView(cornerRadius: width / 2)
        super.init(frame: CGRect.zero)
        addSubview(first)
        setAnchor(targetView: first, rightView: nil, selected: false)
        first.sizeToFit()

        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: first.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: first.trailingAnchor).isActive = true
        sizeToFit()
    }

    func create(occupiedCount: Int, size: Int) {
        for view in views { view.removeFromSuperview() }

        guard occupiedCount >= 0, size >= 0 else {
            first.isHidden = true
            return
        }

        first.backgroundColor = occupiedCount == size ? Color.theme : .gray
        var previous: StandardImageView = first
        for i in 1..<size {
            let selected = size - i <= occupiedCount
            let current = StandardImageView(cornerRadius: width / 2)
            views.append(current)
            addSubview(current)
            setAnchor(targetView: current, rightView: previous, selected: selected)
            current.sizeToFit()
            previous = current
        }
    }

    private func setAnchor(targetView: UIView, rightView: UIView?, selected: Bool) {
        if let rightView = rightView {
            targetView.rightAnchor.constraint(equalTo: rightView.leftAnchor, constant: -5).isActive = true
        } else {
            targetView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        }
        targetView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: height).isActive = true
        targetView.widthAnchor.constraint(equalToConstant: width).isActive = true
        targetView.backgroundColor = selected ? Color.theme : .gray
        targetView.layer.borderWidth = 1
        targetView.layer.masksToBounds = true
        targetView.layer.borderColor = UIColor.white.cgColor
    }

}
