//
//  StandardActivityView.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class StandardActivityView: UIActivityIndicatorView {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(cornerRadius: CGFloat = 5) {
        super.init(style: .gray)
        self.startAnimating()
        self.backgroundColor = .clear
        self.layer.cornerRadius = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
