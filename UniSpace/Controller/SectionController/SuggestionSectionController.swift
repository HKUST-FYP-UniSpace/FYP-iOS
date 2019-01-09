//
//  SuggestionSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class SuggestionSectionController: ListSectionController, ListAdapterDataSource {

    var contentOffset: CGFloat = 0
    var cellSpacing: CGFloat = 10
    private var number: Int?

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
        if index == 0 {
            return CGSize(width: collectionContext!.containerSize.width, height: 80)
        }

        return CGSize(width: collectionContext!.containerSize.width, height: 300)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index == 0 {
            let cell = collectionContext?.dequeueReusableCell(of: TitleCell.self, for: self, at: index)
            if let cell = cell as? TitleCell {
                cell.titleLabel.text = "Suggestions"
                cell.subTitleLabel.text = "Teams that fit you the most"
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
        guard let number = number else { return [] }
        return (0..<number).map { $0 as ListDiffable }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = EmbeddedSectionController()
        sectionController.cellSpacing = cellSpacing
        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}

extension SuggestionSectionController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        collectionView.snapToCell(velocity: velocity, targetOffset: targetContentOffset, spacing: cellSpacing)
        contentOffset = targetContentOffset.pointee.x
    }
}


extension UICollectionView {

    func snapToCell(velocity: CGPoint, targetOffset: UnsafeMutablePointer<CGPoint>, contentInset: CGFloat = 0, spacing: CGFloat = 0) {
        // No snap needed as we're at the end of the scrollview
        guard (contentOffset.x + frame.size.width) < contentSize.width else { return }
        guard let indexPath = indexPathForItem(at: targetOffset.pointee) else { return }
        guard let cellLayout = layoutAttributesForItem(at: indexPath) else { return }

        var offset = targetOffset.pointee

        if velocity.x < 0 {
            offset.x = cellLayout.frame.minX - max(contentInset, spacing)
        } else {
            offset.x = cellLayout.frame.maxX - contentInset + min(contentInset, spacing)
        }

        offset.x -= spacing
        targetOffset.pointee = offset
    }
}
