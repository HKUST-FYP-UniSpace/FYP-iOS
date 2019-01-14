//
//  StandardButton.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class StandardButton: UIButton {

    override open var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                self.backgroundColor = self.isHighlighted ? Color.Button.hightlighted : Color.Button.background
            }, completion: nil)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(buttonText: String? = nil) {
        super.init(frame: CGRect.zero)
        isHighlighted = false
        self.setup(buttonText)
    }

    private func setup(_ buttonText: String?) {
        let textColor = Color.Button.text

        self.setTitle(buttonText, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.setTitleColor(textColor, for: .normal)
        self.clipsToBounds = true
        self.adjustsImageWhenHighlighted = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
