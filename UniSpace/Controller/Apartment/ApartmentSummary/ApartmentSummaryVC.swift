//
//  ApartmentSummaryVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class ApartmentSummaryVC: MasterVC, ListAdapterDataSource, Bookmarkable {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var isBookmarked: Bool
    var houseId: Int?
    var data: HouseViewModel?

    init(isBookmarked: Bool = false) {
        self.isBookmarked = isBookmarked
        super.init(nibName: nil, bundle: nil)
        navigationItem.rightBarButtonItem = createBookmark(isBookmarked: isBookmarked)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func heartButton(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        guard let houseId = houseId else { return }
        self.isBookmarked = !self.isBookmarked
        self.navigationItem.rightBarButtonItem = self.createBookmark(isBookmarked: self.isBookmarked)
        generator.notificationOccurred(.success)
        DataStore.shared.bookmarkHouse(houseId: houseId) { (msg, error) in
            guard !self.sendFailed(msg, error: error) else { return }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLargeTitle()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    override func loadData() {
        guard let houseId = houseId else { return }
        DataStore.shared.getHouseView(houseId: houseId) { (model, error) in
            self.data = model
            self.title = model?.titleView?.title
            self.adapter.reloadData(completion: nil)

            self.isBookmarked = model?.titleView?.isBookmarked ?? false
            self.navigationItem.rightBarButtonItem = self.createBookmark(isBookmarked: self.isBookmarked)
        }
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data == nil ? [] : [data!]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        var sectionControllers: [ListSectionController] = []
        if data?.titleView != nil { sectionControllers.append(RowSectionController(type: .HouseSummary))}
        sectionControllers.append(ApartmentTeamSummarySectionController())
        if data?.reviews.count != 0 { sectionControllers.append(ReviewSectionController()) }
        let sectionController = ListStackedSectionController(sectionControllers: sectionControllers)
        sectionController.inset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
