//
//  LoginTextField.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup("", true)
    }
    
    init(text: String?, inverseColor: Bool = false) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.setup(text, inverseColor)
    }
    
    private func setup(_ text: String?, _ inverseColor: Bool) {
        let color = inverseColor ? Color.Login.inverseDetail : Color.Login.detail
        self.borderStyle = .none
        self.backgroundColor = inverseColor ? Color.theme : .clear
        self.placeholder = text
        self.textColor = color
        self.font = font?.withSize(20)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
