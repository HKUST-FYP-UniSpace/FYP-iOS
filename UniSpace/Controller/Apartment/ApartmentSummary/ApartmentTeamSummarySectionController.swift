//
//  ApartmentTeamSummarySectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

enum ApartmentTeamSummarySectionType: String {
    case Teams = "Teams"
    case ArrangingTeams = "Arranging"
    case FormingTeams = "Forming"
}

final class ApartmentTeamSummarySectionController: ListSectionController, ListAdapterDataSource {

    private var type: ApartmentTeamSummarySectionType
    var contentOffset: CGFloat = 0
    private var houseId: Int?
    private var models: [HouseTeamSummaryModel]?
    private var cellSpacing: CGFloat = 10

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()

    init(_ type: ApartmentTeamSummarySectionType) {
        self.type = type
        super.init()
    }

    override func numberOfItems() -> Int {
        return type == .Teams ? 3 : 2
    }

    override func sizeForItem(at index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: 30)
        case 1:
            let teamCount = models?.count ?? 0
            return CGSize(width: collectionContext!.containerSize.width, height: 100 * CGFloat(teamCount))
        case 2:
            return CGSize(width: collectionContext!.containerSize.width, height: 80)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index)
            if let cell = cell as? SectionHeaderCell {
                cell.titleLabel.text = type.rawValue
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
        switch type {
        case .Teams:
            let object = object as? HouseViewModel
            houseId = object?.id
            models = object?.teams

        case .ArrangingTeams:
            let object = object as? OwnerTeamsModel
            models = object?.arrangingTeams

        case .FormingTeams:
            let object = object as? OwnerTeamsModel
            models = object?.formingTeams
        }

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
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        guard let houseId = houseId else { return }
        generator.notificationOccurred(.success)
        adapter.viewController?.present(UINavigationController(rootViewController: TeamCreationVC(houseId: houseId)), animated: true, completion: nil)
    }
}
