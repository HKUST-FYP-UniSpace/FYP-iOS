//
//  ChangeImageCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 22/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

final class ChangeImageRow: Row<ChangeImageCell>, RowType {
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<ChangeImageCell>()
    }
}

class ChangeImageCell: Cell<String>, CellType, ImageSettable {

    private var photoView: StandardImageView
    private var cameraIconView: UIImageView
    private let iconHeight: CGFloat = 30

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        photoView = StandardImageView(hasBackground: true)
        cameraIconView = UIImageView(image: UIImage(named: "Camera"))
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(photoView)
        contentView.addSubview(cameraIconView)

        photoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photoView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        photoView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: 0.75).isActive = true

        cameraIconView.translatesAutoresizingMaskIntoConstraints = false
        cameraIconView.heightAnchor.constraint(equalToConstant: iconHeight).isActive = true
        cameraIconView.widthAnchor.constraint(equalToConstant: iconHeight).isActive = true
        cameraIconView.centerXAnchor.constraint(equalTo: photoView.centerXAnchor).isActive = true
        cameraIconView.centerYAnchor.constraint(equalTo: photoView.centerYAnchor).isActive = true

        photoView.sizeToFit()
        cameraIconView.sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setup() {
        super.setup()
        selectionStyle = .none
        height = { return Constants.screenWidth * 0.75 }
    }

    func setImage(_ image: UIImage?) {
        photoView.image = image
        cameraIconView.isHidden = image == nil ? false : true
        photoView.setBackground(hasBackground: image == nil)
    }

}
