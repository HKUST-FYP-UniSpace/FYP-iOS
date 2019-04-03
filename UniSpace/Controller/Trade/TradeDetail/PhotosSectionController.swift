//
//  PhotosSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 10/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class PhotosSectionController: ListSectionController, ListAdapterDataSource {

    var contentOffset: CGFloat = 0
    private var photos: [String] = []

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        return adapter
    }()

    override func numberOfItems() -> Int {
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat = collectionContext!.containerSize.width
        return CGSize(width: width, height: width * 0.75)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: EmbeddedCollectionViewCell.self,
                                                                for: self,
                                                                at: index) as? EmbeddedCollectionViewCell else {
                                                                    fatalError()
        }
        adapter.collectionView = cell.collectionView
        return cell
    }

    override func didUpdate(to object: Any) {
        if let model = object as? TradeFeaturedModel {
            photos = model.photoURLs
        }

        if let model = object as? HouseViewModel {
            photos = model.titleView?.photoURLs ?? []
        }
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return photos.map { $0 as ListDiffable }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let sectionController = EmbeddedSectionController(.Images)
        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}

extension PhotosSectionController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        collectionView.snapToCell(velocity: velocity, targetOffset: targetContentOffset, spacing: 0)
        contentOffset = targetContentOffset.pointee.x
    }
}
