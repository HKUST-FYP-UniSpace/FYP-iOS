//
//  LoginLabel.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class LoginLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(labelText: String?, isTitle: Bool, inverseColor: Bool = false) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.setup(labelText, isTitle, inverseColor)
    }
    
    private func setup(_ labelText: String?, _ isTitle: Bool, _ inverseColor: Bool) {
        self.text = labelText ?? ""
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 8
        self.textColor = getColor(isTitle, inverseColor)
        let textSize: CGFloat = isTitle ? 32 : 20
        self.font = UIFont.boldSystemFont(ofSize: textSize)
        self.textAlignment = .center

        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func getColor(_ isTitle: Bool, _ inverseColor: Bool) -> UIColor {
        if isTitle {
            return inverseColor ? Color.Login.inverseTitle : Color.Login.title
        } else {
            return inverseColor ? Color.Login.inverseDetail : Color.Login.detail
        }
    }
    
}
