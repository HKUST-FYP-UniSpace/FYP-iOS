//
//  StandardImageView.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class StandardImageView: UIImageView {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(cornerRadius: CGFloat = 0, hasBackground: Bool = false, hasShadow: Bool = false) {
        super.init(frame: CGRect.zero)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.backgroundColor = hasBackground ? UIColor(white: 0.95, alpha: 1) : .clear
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func setBackground(hasBackground: Bool) {
        self.backgroundColor = hasBackground ? UIColor(white: 0.95, alpha: 1) : .clear
    }

}
