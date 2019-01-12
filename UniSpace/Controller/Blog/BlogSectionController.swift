//
//  BlogSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 12/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import IGListKit

final class BlogSectionController: ListSectionController, ListAdapterDataSource {

    var contentOffset: CGFloat = 0
    private var number: Int?
    private var cellSpacing: CGFloat = 10

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self.viewController, workingRangeSize: 4)
        adapter.dataSource = self
        return adapter
    }()

    override func numberOfItems() -> Int {
        return 5
    }

    override func sizeForItem(at index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: 60)
        case 1, 2, 3, 4:
            return CGSize(width: collectionContext!.containerSize.width, height: 500)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(of: TitleCell.self, for: self, at: index)
            if let cell = cell as? TitleCell {
                cell.titleLabel.text = "Blog"
                return cell
            }
            fatalError()

        case 1, 2, 3, 4:
            guard let cell = collectionContext?.dequeueReusableCell(of: VerticalExpandCollectionViewCell.self,
                                                                    for: self,
                                                                    at: index) as? VerticalExpandCollectionViewCell else {
                                                                        fatalError()
            }
            adapter.collectionView = cell.collectionView
            return cell

        default:
            fatalError()
        }
    }

    override func didUpdate(to object: Any) {
        number = object as? Int
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [0 as ListDiffable]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return GridSectionController(.Blog)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
