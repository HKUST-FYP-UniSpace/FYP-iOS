//
//  UserInfoCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 16/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

final class UserInfoRow: Row<UserInfoCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<UserInfoCell>()
    }
}

class UserInfoCell: Cell<UserProfileModel>, CellType, ImageSettable {

    var nameLabel: StandardLabel
    var preferenceLabel: StandardLabel
    private var photoView: StandardImageView

    private let imageHeight: CGFloat = 100

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        nameLabel = StandardLabel(color: .darkGray, size: 18, isBold: true)
        preferenceLabel = StandardLabel(color: .darkGray, size: 14, isBold: false)
        photoView = StandardImageView(cornerRadius: imageHeight / 2, hasBackground: true)

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setup() {
        super.setup()
        selectionStyle = .none
        height = { return 220 }
    }

    private func setupViews() {
        let views = [nameLabel, preferenceLabel, photoView]
        for view in views { contentView.addSubview(view) }

        photoView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.wide).isActive = true
        photoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        photoView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true

        nameLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: Spacing.wide).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        preferenceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Spacing.normal).isActive = true
        preferenceLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        for view in views { view.sizeToFit() }
    }

    func setImage(image: UIImage?) {
        photoView.image = image
        photoView.setBackground(hasBackground: image == nil)
    }

}
