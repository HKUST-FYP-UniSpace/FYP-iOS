//
//  TradeCategorySectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class TradeCategorySectionController: ListSectionController {

    var contentOffset: CGFloat = 0
    private var number: Int?
    private var cellSpacing: CGFloat = 10
    private let cats = ["Electronics and Gadgets", "Furnitures", "Kitchenwares"]

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        return adapter
    }()

    override func numberOfItems() -> Int {
        return 4
    }

    override func sizeForItem(at index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: 60)
        case 1, 2, 3:
            return CGSize(width: collectionContext!.containerSize.width, height: 60)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(of: TitleCell.self, for: self, at: index)
            if let cell = cell as? TitleCell {
                cell.titleLabel.text = "Category"
                return cell
            }
            fatalError()

        case 1, 2, 3:
            let cell = collectionContext?.dequeueReusableCell(of: LabelCell.self, for: self, at: index)
            if let cell = cell as? LabelCell {
                cell.label.text = cats[index - 1]
                cell.label.tintColor = Color.theme
                return cell
            }
            fatalError()

        default:
            fatalError()
        }
    }

    override func didUpdate(to object: Any) {
        number = object as? Int
    }
}
