//
//  OwnerSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class OwnerSectionController: ListSectionController {

    var contentOffset: CGFloat = 0
    private var model: OwnerHouseSummaryModel?

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        return adapter
    }()

    override func numberOfItems() -> Int {
        return 7
    }

    override func sizeForItem(at index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: 60)
        case 1:
            return CGSize(width: collectionContext!.containerSize.width, height: 30)
        case 2:
            return CGSize(width: collectionContext!.containerSize.width, height: 100)
        case 3:
            return CGSize(width: collectionContext!.containerSize.width, height: 30)
        case 4:
            return CGSize(width: collectionContext!.containerSize.width, height: 100)
        case 5:
            return CGSize(width: collectionContext!.containerSize.width, height: 30)
        case 6:
            return CGSize(width: collectionContext!.containerSize.width, height: 140)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let model = model else { fatalError() }

        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(of: TitleCell.self, for: self, at: index)
            if let cell = cell as? TitleCell {
                cell.titleLabel.text = model.title.capitalized
                cell.subtitleLabel.text = nil
                return cell
            }
            fatalError()

        case 1:
            let cell = collectionContext?.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index)
            if let cell = cell as? SectionHeaderCell {
                cell.titleLabel.text = "Info".uppercased()
                cell.titleLabel.textColor = Color.theme
                return cell
            }
            fatalError()

        case 2:
            let cell = collectionContext?.dequeueReusableCell(of: OwnerInfoCell.self, for: self, at: index)
            if let cell = cell as? OwnerInfoCell {
                cell.addressLabel.text = model.address
                cell.priceLabel.text = "$\(model.price.addComma()!)"
                cell.sizeLabel.text = "\(model.size.addComma()!) sq. ft."
                cell.setup(type: model.houseStatus)
                return cell
            }
            fatalError()

        case 3:
            let cell = collectionContext?.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index)
            if let cell = cell as? SectionHeaderCell {
                cell.titleLabel.text = "Stats".uppercased()
                cell.titleLabel.textColor = Color.theme
                return cell
            }
            fatalError()

        case 4:
            let cell = collectionContext?.dequeueReusableCell(of: OwnerStatsCell.self, for: self, at: index)
            if let cell = cell as? OwnerStatsCell {
                cell.numberOfViewsTitleLabel.text = "Total # of views per week"
                cell.numberOfViewsLabel.text = "\(model.numberOfViews.addComma()!)"
                cell.statsTitleLabel.text = "Total # of bookmarks per week"
                cell.statsLabel.text = "\(model.numberOfBookmarks.addComma()!)"
                return cell
            }
            fatalError()

        case 5:
            let cell = collectionContext?.dequeueReusableCell(of: SectionHeaderCell.self, for: self, at: index)
            if let cell = cell as? SectionHeaderCell {
                cell.titleLabel.text = "Teams & Response".uppercased()
                cell.titleLabel.textColor = Color.theme
                return cell
            }
            fatalError()

        case 6:
            let cell = collectionContext?.dequeueReusableCell(of: OwnerTeamsCell.self, for: self, at: index)
            if let cell = cell as? OwnerTeamsCell {
                cell.arrangingTitleLabel.text = "Arranging"
                cell.arrangingLabel.text = "\(model.arrangingTeamCount.addComma()!) teams"
                cell.formingTitleLabel.text = "Forming"
                cell.formingLabel.text = "\(model.formingTeamCount.addComma()!) teams"
                cell.ratingsTitleLabel.text = "Ratings"
                cell.setStarRating(rating: model.starRating)
                return cell
            }
            fatalError()
        default:
            fatalError()
        }
    }

    override func didSelectItem(at index: Int) {
        switch index {
        case 2:
            log.debug("OwnerInfoCell")

        case 4:
            let vc = ChartVC()
            vc.id = model?.id
            vc.isHouse = true
            adapter.viewController?.navigationController?.pushViewController(vc, animated: true)

        case 6:
            log.debug("OwnerTeamsCell")
            let vc = OwnerTeamVC()
            vc.houseId = model?.id
            adapter.viewController?.navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }

    override func didUpdate(to object: Any) {
        model = object as? OwnerHouseSummaryModel
    }

}
