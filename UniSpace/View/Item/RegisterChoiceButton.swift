//
//  RegisterChoiceButton.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class RegisterChoiceButton: UIButton {
    
    lazy private var textLabel = LoginLabel(labelText: nil, isTitle: true)
    lazy private var iconImage = UIImageView(image: nil)
    
    override open var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut,. allowUserInteraction], animations: {
                self.backgroundColor = self.isHighlighted ? Color.Option.hightlighted : Color.Option.background
            }, completion: nil)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setup("", nil)
    }
    
    init(buttonText: String?, buttonImage: UIImage?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 80, height: 32))
        isHighlighted = false
        self.setup(buttonText, buttonImage)
    }
    
    private func setup(_ buttonText: String?, _ buttonImage: UIImage?) {
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.adjustsImageWhenHighlighted = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupTextLabel(buttonText)
        setupImageView(buttonImage)
        self.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    private func setupTextLabel(_ buttonText: String?) {
        addSubview(textLabel)
        textLabel.text = buttonText
        textLabel.textAlignment = .left
        textLabel.leftAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupImageView(_ image: UIImage?) {
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false

        iconImage.image = image
        iconImage.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -50).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 75).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
}
