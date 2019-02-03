//
//  SavedSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class SavedSectionController: ListSectionController, ListAdapterDataSource {

    var contentOffset: CGFloat = 0
    private var model: HouseHomepageModel?
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
            return CGSize(width: collectionContext!.containerSize.width, height: 60)
        case 1:
            return CGSize(width: collectionContext!.containerSize.width, height: 400)
        case 2:
            return CGSize(width: collectionContext!.containerSize.width, height: 40)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(of: TitleCell.self, for: self, at: index)
            if let cell = cell as? TitleCell {
                cell.titleLabel.text = "Saved"
                cell.subTitleLabel.text = nil
                cell.setImage(image: nil)
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

        case 2:
            let cell = collectionContext?.dequeueReusableCell(of: ButtonCell.self, for: self, at: index)
            if let cell = cell as? ButtonCell {
                cell.button.setTitle("See All", for: .normal)
                return cell
            }
            fatalError()
        default:
            fatalError()
        }
    }

    override func didUpdate(to object: Any) {
        model = object as? HouseHomepageModel
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return model == nil ? [] : [model!]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return GridSectionController(.HouseSaved)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
