//
//  CenterLabelCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

final class CenterLabelCell: UICollectionViewCell {

    lazy private var label: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 18)
        self.contentView.addSubview(view)
        return view
    }()

    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
        layer.cornerRadius = 20.0
        
        // Shadow
//        layer.shadowColor = UIColor.gray.cgColor
//        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        layer.shadowRadius = 14.0
//        layer.shadowOpacity = 0.7
    }

}
