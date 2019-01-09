//
//  EmbeddedSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class EmbeddedSectionController: ListSectionController {

    var cellSpacing: CGFloat = 10
    private var number: Int?

    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width = UIScreen.main.bounds.width - cellSpacing * 6
        let height = collectionContext?.containerSize.height ?? 0
        return CGSize(width: width, height: height)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: CenterLabelCell.self, for: self, at: index) as? CenterLabelCell else {
            fatalError()
        }
        let value = number ?? 0
        cell.text = "\(value + 1)"
        cell.backgroundColor = Color.theme
        return cell
    }

    override func didUpdate(to object: Any) {
        number = object as? Int
    }

}
