//
//  SingleSectionViewController.swift
//  UniSpace
//
//  Created by KiKan Ng on 31/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

class SingleSectionViewController: MasterVC, ListAdapterDataSource, ListSingleSectionControllerDelegate {

    var data: [ListDiffable]?
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    func completion(_ models: [ListDiffable]?, _ error: Error?) {
        self.data = models
        self.adapter.reloadData(completion: nil)
    }

    func completion(_ model: ListDiffable?, _ error: Error?) {
        self.data = model == nil ? nil : [model!]
        self.adapter.reloadData(completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        guard let data = data else { return [] }
        return data
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ListSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

    // MARK: ListSingleSectionControllerDelegate
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {}

}
