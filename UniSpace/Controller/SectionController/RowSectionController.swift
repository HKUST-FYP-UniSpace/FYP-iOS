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
    case TeamDescription
    case TeamMembers
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
            case .HouseSummary: return collectionContext!.containerSize.width * 0.75 + 170
            case .HouseSummaryTeam: return 100
            case .TeamDescription: return 100
            case .TeamMembers: return 80
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
        case .TeamDescription:
            return getTeamSummaryCell(at: index)
        case .TeamMembers:
            return getTeamMemberCell(at: index)
        }
    }

    override func didUpdate(to object: Any) {
        if let model = object as? TeamSummaryViewModel {
            self.object = model.teamView
            return
        }
        self.object = object as? ListDiffable
    }

    override func didSelectItem(at index: Int) {
        switch type {
        case .HouseSummaryTeam:
            let vc = TeamSummaryVC()
            vc.teamId = 0
            viewController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        default:
            return
        }
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
        guard let cell = collectionContext?.dequeueReusableCell(of: HouseTeamSummaryCell.self, for: self, at: index) as? HouseTeamSummaryCell, let object = object as? HouseTeamSummaryModel else { fatalError() }
        cell.titleLabel.text = object.title
        cell.priceLabel.text = "$\(object.price.addComma()!) pcm"
        cell.durationLabel.text = object.duration
        cell.subtitleLabel.text = object.subtitle
        cell.createGroup(occupiedCount: object.occupiedCount, size: object.groupSize)
        return cell
    }

    private func getTeamSummaryCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: TeamSummaryCell.self, for: self, at: index) as? TeamSummaryCell, let object = object as? String else { fatalError() }
        cell.label.text = object
        return cell
    }

    private func getTeamMemberCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: TeamMemberCell.self, for: self, at: index) as? TeamMemberCell, let object = object as? TeamMemberModel else { fatalError() }
        cell.nameLabel.text = object.name
        cell.roleLabel.text = object.role.text
        cell.setImage(image: nil)

        AlamofireService.shared.downloadImageData(at: object.photoURL, downloadProgress: nil) { (data, error) in
            guard let data = data else { return }
            cell.setImage(image: UIImage(data: data))
        }
        return cell
    }

}
