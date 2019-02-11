//
//  TradeVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 17/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class TradeVC: MasterLandingPageVC, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    let data: [TradeHomepageModel] = [TradeHomepageModel()]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    private func loadData() {
        var featured: [TradeFeaturedModel] = []
        var sellingItems: [TradeSellingItemModel] = []
        var saved: [TradeFeaturedModel] = []
        var categories: [TradeCategoryModel] = []

        let group = DispatchGroup()
        group.enter()
        DataStore.shared.getTradeFeatured { (models, error) in
            featured = models ?? []
            group.leave()
        }

        group.enter()
        DataStore.shared.getTradeSellingItems { (models, error) in
            sellingItems = models ?? []
            group.leave()
        }

        group.enter()
        DataStore.shared.getTradeSaved { (models, error) in
            saved = models ?? []
            group.leave()
        }

        group.enter()
        DataStore.shared.getTradeCategories { (models, error) in
            categories = models ?? []
            group.leave()
        }

        group.notify(queue: .main) {
            self.data[0].featured = featured
            self.data[0].sellingItems = sellingItems
            self.data[0].saved = saved
            self.data[0].categories = categories
            self.adapter.reloadData(completion: nil)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        adapter.viewController?.navigationController?.pushViewController(TradeListVC(.Result), animated: true)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data as [ListDiffable]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        var sectionControllers: [ListSectionController] = []
        if data[0].featured.count != 0 { sectionControllers.append(TradeFeaturedSectionController()) }
        if data[0].sellingItems.count != 0 { sectionControllers.append(TradeSellingItemsSectionController()) }
        if data[0].saved.count != 0 { sectionControllers.append(TradeSavedSectionController()) }
        if data[0].categories.count != 0 { sectionControllers.append(TradeCategorySectionController()) }
        let sectionController = ListStackedSectionController(sectionControllers: sectionControllers)
        sectionController.inset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
