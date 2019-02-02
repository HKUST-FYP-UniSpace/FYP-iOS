//
//  CustomCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 16/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    internal let buttonWidth: CGFloat = 80
    internal let leftItemFromX: CGFloat = -60
    internal let rightItemFromX: CGFloat = -40
    internal let seperateDis: CGFloat = 16

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
