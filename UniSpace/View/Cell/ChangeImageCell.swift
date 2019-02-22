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

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        photoView = StandardImageView(hasBackground: true)
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(photoView)
        photoView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photoView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        photoView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: 0.75).isActive = true
        photoView.sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setup() {
        super.setup()
        selectionStyle = .none
        height = { return Constants.screenWidth * 0.75 }
    }

    func setImage(image: UIImage?) {
        photoView.image = image
        photoView.setBackground(hasBackground: image == nil)
    }

}
