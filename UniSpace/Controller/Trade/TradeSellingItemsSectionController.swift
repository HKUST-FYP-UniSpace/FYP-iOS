//
//  TradeSellingItemsSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class TradeSellingItemsSectionController: ListSectionController, ListAdapterDataSource {

    var contentOffset: CGFloat = 0
    private var number: Int?
    private var cellSpacing: CGFloat = 10

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        return adapter
    }()

    override func numberOfItems() -> Int {
        return 2
    }

    override func sizeForItem(at index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: 60)
        case 1:
            return CGSize(width: collectionContext!.containerSize.width, height: 240)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            let cell = collectionContext?.dequeueReusableCell(of: TitleCell.self, for: self, at: index)
            if let cell = cell as? TitleCell {
                cell.titleLabel.text = "Your Selling Items"
                return cell
            }
            fatalError()
        }

        guard let cell = collectionContext?.dequeueReusableCell(of: EmbeddedCollectionViewCell.self,
                                                                for: self,
                                                                at: index) as? EmbeddedCollectionViewCell else {
                                                                    fatalError()
        }
        adapter.collectionView = cell.collectionView
        return cell
    }

    override func didUpdate(to object: Any) {
        number = object as? Int
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return (0..<2).map { $0 as ListDiffable }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = EmbeddedSectionController(.TradeSellingItems)
        sectionController.cellSpacing = cellSpacing
        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}

extension TradeSellingItemsSectionController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        collectionView.snapToCell(velocity: velocity, targetOffset: targetContentOffset, spacing: cellSpacing)
        contentOffset = targetContentOffset.pointee.x
    }
}
