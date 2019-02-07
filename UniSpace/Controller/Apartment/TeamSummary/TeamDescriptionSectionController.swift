//
//  TeamDescriptionSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class TeamDescriptionSectionController: ListSectionController, ListAdapterDataSource {

    var contentOffset: CGFloat = 0
    private var model: String?
    private var cellSpacing: CGFloat = 10

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()

    override func numberOfItems() -> Int {
        return 3
    }

    override func sizeForItem(at index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: 30)
        case 1:
            return CGSize(width: collectionContext!.containerSize.width, height: 140)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index)
            if let cell = cell as? SectionHeaderCell {
                cell.titleLabel.text = "Description"
                return cell
            }
            fatalError()

        case 1:
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
        let object = object as? TeamSummaryViewModel
        model = object?.teamView?.description
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return model == nil ? [] : [model! as ListDiffable]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return RowSectionController(type: .TeamDescription)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
