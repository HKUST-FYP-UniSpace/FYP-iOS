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
    private var cellSpacing: CGFloat = 10
    private var cats: [TradeCategory] = []

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        return adapter
    }()

    override func numberOfItems() -> Int {
        return cats.count + 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: 60)
        default:
            return CGSize(width: collectionContext!.containerSize.width, height: 60)
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(of: TitleCell.self, for: self, at: index)
            if let cell = cell as? TitleCell {
                cell.titleLabel.text = "Category"
                cell.setImage(nil)
                return cell
            }
            fatalError()

        default:
            let cell = collectionContext?.dequeueReusableCell(of: LabelCell.self, for: self, at: index)
            if let cell = cell as? LabelCell {
                cell.label.text = cats[index - 1].rawValue
                cell.label.tintColor = Color.theme
                return cell
            }
            fatalError()
        }
    }

    override func didUpdate(to object: Any) {
        let model = object as? TradeHomepageModel
        cats = model?.categories ?? []
    }

    override func didSelectItem(at index: Int) {
        guard index != 0 else { return }
        let cat = cats[index - 1]
        let vc = TradeListVC(.Result)
        vc.title = cat.rawValue
        vc.filter.category = [cat]
        adapter.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
