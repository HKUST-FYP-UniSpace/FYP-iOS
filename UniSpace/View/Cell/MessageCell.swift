//
//  MessageCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 16/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell, ImageSettable {

    var titleLabel: StandardLabel
    var subtitleLabel: StandardLabel
    var timeLabel: StandardLabel
    var messagesCountLabel: MessageTypeButton
    var typeLabel: MessageTypeButton
    var imageView: StandardImageView
    fileprivate let separator: CALayer

    private let imageHeight: CGFloat = 60

    override init(frame: CGRect) {
        titleLabel = StandardLabel(color: .darkGray, size: 18, isBold: true)
        subtitleLabel = StandardLabel(color: .gray, size: 14, isBold: false)
        timeLabel = StandardLabel(color: .gray, size: 14, isBold: false, align: .right)
        messagesCountLabel = MessageTypeButton(isNumber: true)
        typeLabel = MessageTypeButton(isNumber: false)
        imageView = StandardImageView(cornerRadius: imageHeight / 2, hasBackground: true)
        separator = StandardSeparator()

        super.init(frame: frame)
        setupImageView()
        setupViews()
    }

    func setup(messageType: MessageType, newMessagesCount: Int = 0) {
        typeLabel.setType(title: messageType.text, color: messageType.color)
        imageView.layer.borderColor = messageType.color.cgColor

        if newMessagesCount > 0 {
            messagesCountLabel.isHidden = false
            messagesCountLabel.setType(title: "\(newMessagesCount)", color: messageType.color)
        } else {
            messagesCountLabel.isHidden = true
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.layer.addSublayer(separator)
        let views = [titleLabel, subtitleLabel, timeLabel, messagesCountLabel, typeLabel, imageView]
        for view in views { contentView.addSubview(view) }

        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Spacing.narrow).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true

        typeLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -Spacing.narrow).isActive = true
        typeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Spacing.normal).isActive = true

        messagesCountLabel.bottomAnchor.constraint(equalTo: typeLabel.bottomAnchor).isActive = true
        messagesCountLabel.rightAnchor.constraint(equalTo: typeLabel.leftAnchor, constant: -Spacing.narrow).isActive = true

        titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -Spacing.narrow).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: Spacing.normal).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: messagesCountLabel.leftAnchor, constant: -Spacing.normal).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        timeLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: Spacing.normal).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: typeLabel.rightAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true

        subtitleLabel.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: -Spacing.normal).isActive = true

        for view in views { view.sizeToFit() }
        messagesCountLabel.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let bounds = contentView.bounds
        let height: CGFloat = 0.5
        let left: CGFloat = 15
        separator.frame = CGRect(x: left, y: bounds.height - height, width: bounds.width - left, height: height)
    }


    private func setupImageView() {
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
    }

    func setImage(image: UIImage?) {
        imageView.image = image
        imageView.setBackground(hasBackground: image == nil)
    }
    
}
