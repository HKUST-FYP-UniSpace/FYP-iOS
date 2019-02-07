//
//  TeamSummaryVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class TeamSummaryVC: MasterPopupVC, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var teamId: Int?
    var data: TeamSummaryViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    private func loadData() {
        guard let teamId = teamId else { return }
        DataStore.shared.getTeamView(teamId: teamId) { (model, error) in
            self.data = model
            self.adapter.reloadData(completion: nil)
        }
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data == nil ? [] : [data!]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        var sectionControllers: [ListSectionController] = []
        if data?.teamView != nil {
            sectionControllers.append(RowSectionController(type: .HouseSummaryTeam))
            sectionControllers.append(TeamDescriptionSectionController())
        }
        sectionControllers.append(TeamMemberSectionController())
        let sectionController = ListStackedSectionController(sectionControllers: sectionControllers)
        sectionController.inset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        return sectionController
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }
}
