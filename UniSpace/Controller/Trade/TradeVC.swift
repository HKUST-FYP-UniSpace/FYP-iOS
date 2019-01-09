//
//  TradeVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 17/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class TradeVC: MasterVC, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    let data = [128, 256, 64]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data as [ListDiffable]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        // note that each child section controller is designed to handle an Int (or no data)
        let sectionController = ListStackedSectionController(sectionControllers: [
            WorkingRangeSectionController(),
            DisplaySectionController(),
            HorizontalSectionController()
            ])
        sectionController.inset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
