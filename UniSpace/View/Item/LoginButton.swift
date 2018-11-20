//
//  LoginButton.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class LoginButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup("")
    }
    
    init(buttonText: String?, inverseColor: Bool = false) {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 32))
        self.setup(buttonText, inverseColor)
    }
    
    private func setup(_ buttonText: String?, _ inverseColor: Bool = false) {
        let textColor = inverseColor ? Color.InverseButton.text : Color.Button.text
        let backgroundColor = inverseColor ? Color.InverseButton.background : Color.Button.background
        
        self.setTitle(buttonText, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.setTitleColor(textColor, for: .normal)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
        self.adjustsImageWhenHighlighted = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
}
