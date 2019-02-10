//
//  StandardSeperator.swift
//  UniSpace
//
//  Created by KiKan Ng on 9/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class StandardSeparator: CALayer {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init() {
        super.init()
        backgroundColor = UIColor(red: 200 / 255.0, green: 199 / 255.0, blue: 204 / 255.0, alpha: 1).cgColor
    }

}
