//
//  UITextField+BottomBorder.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder(inverseColor: Bool = false) {
        self.borderStyle = .none
        self.layer.backgroundColor = inverseColor ? Color.theme.cgColor : UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = Color.Login.detail.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
