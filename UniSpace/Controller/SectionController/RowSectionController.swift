//
//  RowSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 7/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

enum RowSectionType {
    case HouseSummary
    case HouseSummaryTeam
}

final class RowSectionController: ListSectionController {

    private var object: ListDiffable?
    private let type: RowSectionType

    init(type: RowSectionType) {
        self.type = type
        super.init()
    }

    override func sizeForItem(at index: Int) -> CGSize {
        var height: CGFloat {
            switch type {
            case .HouseSummary:
                return 480
            case .HouseSummaryTeam:
                return 100
            }
        }
        return CGSize(width: collectionContext!.containerSize.width, height: height)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch type {
        case .HouseSummary:
            return getHouseSummaryCell(at: index)
        case .HouseSummaryTeam:
            return getHouseSummaryTeamCell(at: index)
        }
    }

    override func didUpdate(to object: Any) {
        self.object = object as? ListDiffable
    }

    override func didSelectItem(at index: Int) {
    }

    private func getHouseSummaryCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HouseSummaryCell.self, for: self, at: index) as? HouseSummaryCell, let object = object as? HouseViewModel, let titleView = object.titleView else { fatalError() }
        cell.titleLabel.text = titleView.address
        cell.setStarRating(rating: titleView.starRating)
        cell.priceLabel.text = "$\(titleView.price.addComma()!) pcm"
        cell.sizeLabel.text = "\(titleView.size) sq. ft."
        cell.subtitleLabel.text = titleView.subtitle
        cell.setImage(image: nil)

        AlamofireService.shared.downloadImageData(at: titleView.photoURL, downloadProgress: nil) { (data, error) in
            guard let data = data else { return }
            cell.setImage(image: UIImage(data: data))
        }
        return cell
    }

    private func getHouseSummaryTeamCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HouseSummaryTeamCell.self, for: self, at: index) as? HouseSummaryTeamCell, let object = object as? HouseTeamSummaryModel else { fatalError() }
        cell.titleLabel.text = object.title
        cell.priceLabel.text = "$\(object.price.addComma()!) pcm"
        cell.durationLabel.text = object.duration
        cell.subtitleLabel.text = object.subtitle
        cell.createGroup(occupiedCount: object.occupiedCount, size: object.groupSize)
        return cell
    }

}
