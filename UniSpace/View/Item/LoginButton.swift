//
//  LoginButton.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class LoginButton: UIButton {
    
    private var inverseColor = false
    
    override open var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                if self.inverseColor {
                    self.backgroundColor = self.isHighlighted ? Color.InverseButton.hightlighted : Color.InverseButton.background
                } else {
                    self.backgroundColor = self.isHighlighted ? Color.Button.hightlighted : Color.Button.background
                }
            }, completion: nil)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup("")
    }
    
    init(buttonText: String?, inverseColor: Bool = false) {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 32))
        self.inverseColor = inverseColor
        isHighlighted = false
        self.setup(buttonText)
    }
    
    private func setup(_ buttonText: String?) {
        let textColor = inverseColor ? Color.InverseButton.text : Color.Button.text
        
        self.setTitle(buttonText, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.setTitleColor(textColor, for: .normal)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.adjustsImageWhenHighlighted = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
}
