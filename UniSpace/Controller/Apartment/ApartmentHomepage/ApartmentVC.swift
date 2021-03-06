//
//  ApartmentVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 17/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class ApartmentVC: MasterLandingPageVC, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    let data: [HouseHomepageModel] = [HouseHomepageModel()]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    override func loadData() {
        var suggestions: [HouseSuggestionModel] = []
        var saved: [HouseListModel] = []

        let group = DispatchGroup()
        group.enter()
        DataStore.shared.getHouseSuggestions { (models, error) in
            suggestions = models ?? []
            group.leave()
        }

        group.enter()
        DataStore.shared.getHouseSaved { (models, error) in
            saved = models ?? []
            group.leave()
        }

        group.notify(queue: .main) {
            self.data[0].suggestions = suggestions
            self.data[0].saved = saved
            self.adapter.reloadData(completion: nil)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = ApartmentListVC(.Result)
        vc.filter.keyword = searchBar.text
        adapter.viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data as [ListDiffable]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        var sectionControllers: [ListSectionController] = []
        if data[0].suggestions.count != 0 { sectionControllers.append(SuggestionSectionController()) }
        if data[0].saved.count != 0 { sectionControllers.append(SavedSectionController()) }
        let sectionController = ListStackedSectionController(sectionControllers: sectionControllers)
        sectionController.inset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
