//
//  StandardLabel.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class StandardLabel: UILabel {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(color: UIColor, size: CGFloat, isBold: Bool, text: String? = nil, align: NSTextAlignment = .left, numberOfLines: Int = 1) {
        super.init(frame: CGRect.zero)

        self.text = text
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = numberOfLines
        self.textAlignment = align
        self.backgroundColor = .clear
        self.font = isBold ? .boldSystemFont(ofSize: size) : .systemFont(ofSize: size)
        self.textColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
