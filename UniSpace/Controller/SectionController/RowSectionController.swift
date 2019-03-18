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
    case ScreenWidthImage
    case TradeDetail
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
            case .ScreenWidthImage: return collectionContext!.containerSize.width * 0.75
            case .TradeDetail: return 160
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
        case .ScreenWidthImage:
            return getImageCell(at: index)
        case .TradeDetail:
            return getTradeDetailCell(at: index)
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
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        
        switch type {
        case .HouseSummaryTeam:
            guard let object = self.object as? HouseTeamSummaryModel else { return }
            let vc = TeamSummaryVC()
            vc.teamId = object.id
            DispatchQueue.main.async {
                generator.notificationOccurred(.success)
                self.viewController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            }
        default:
            return
        }
    }

    private func getHouseSummaryCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HouseSummaryCell.self, for: self, at: index) as? HouseSummaryCell, let object = object as? HouseViewModel, let titleView = object.titleView else { fatalError() }
        cell.titleLabel.text = titleView.address
        cell.setStarRating(rating: titleView.starRating)
        cell.priceLabel.text = "$\(titleView.price.addComma()!) pcm"
        cell.sizeLabel.text = "\(titleView.size.addComma()!) sq. ft."
        cell.subtitleLabel.text = titleView.subtitle
        cell.setImage(nil)

        guard let url = titleView.getFirstPhotoURL() else { return cell }
        AlamofireService.shared.downloadImage(at: url, downloadProgress: nil) { (image, error) in
            cell.setImage(image)
        }
        return cell
    }

    private func getHouseSummaryTeamCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HouseTeamSummaryCell.self, for: self, at: index) as? HouseTeamSummaryCell, let object = object as? HouseTeamSummaryModel else { fatalError() }
        cell.titleLabel.text = object.title
        cell.priceLabel.text = "$\(object.price.addComma()!) pcm"
        cell.durationLabel.text = object.duration
        cell.subtitleLabel.text = object.preference.getTextForm()
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
        cell.setImage(nil)

        AlamofireService.shared.downloadImage(at: object.photoURL, downloadProgress: nil) { (image, error) in
            cell.setImage(image)
        }
        return cell
    }

    private func getImageCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as? ImageCell, let object = object as? HouseTeamSummaryModel else { fatalError() }
        cell.setImage(nil)

        AlamofireService.shared.downloadImage(at: object.photoURL, downloadProgress: nil) { (image, error) in
            cell.setImage(image)
        }
        return cell
    }

    private func getTradeDetailCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: TradeDetailCell.self, for: self, at: index) as? TradeDetailCell, let object = object as? TradeFeaturedModel else { fatalError() }
        cell.titleLabel.text = object.title
        cell.locationLabel.text = object.location
        cell.priceLabel.text = "$\(object.price.addComma()!)"
        cell.statusLabel.text = object.status
        cell.subtitleLabel.text = object.detail
        return cell
    }



}
