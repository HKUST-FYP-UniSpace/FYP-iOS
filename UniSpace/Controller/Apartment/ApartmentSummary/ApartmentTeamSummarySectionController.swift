//
//  ApartmentTeamSummarySectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class ApartmentTeamSummarySectionController: ListSectionController, ListAdapterDataSource {

    var contentOffset: CGFloat = 0
    private var models: [HouseTeamSummaryModel]?
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
            return CGSize(width: collectionContext!.containerSize.width, height: 30)
        case 1:
            let teamCount = models?.count ?? 0
            return CGSize(width: collectionContext!.containerSize.width, height: 100 * CGFloat(teamCount))
        case 2:
            return CGSize(width: collectionContext!.containerSize.width, height: 40)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index)
            if let cell = cell as? SectionHeaderCell {
                cell.titleLabel.text = "TEAMS"
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
                cell.delegate = self
                cell.button.setTitle("Create Team", for: .normal)
                return cell
            }
            fatalError()
        default:
            fatalError()
        }
    }

    override func didUpdate(to object: Any) {
        let object = object as? HouseViewModel
        models = object?.teams
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return models == nil ? [] : models!
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return RowSectionController(type: .HouseSummaryTeam)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension ApartmentTeamSummarySectionController: ButtonCellDelegate {
    func buttonCell(pressedButton sender: UIButton) {
    }
}
