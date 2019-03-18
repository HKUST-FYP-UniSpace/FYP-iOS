//
//  EmbeddedSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

enum EmbeddedSectionType {
    case Demo
    case HouseSuggestion
    case TradeSellingItems
    case Reviews
    case Images
}

final class EmbeddedSectionController: ListSectionController {

    var cellSpacing: CGFloat = 10
    private var data: ListDiffable?
    private var type: EmbeddedSectionType

    init(_ type: EmbeddedSectionType) {
        self.type = type
        super.init()
        self.inset = type == .Images
            ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            : UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
        workingRangeDelegate = self
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let size = getSize()
        return CGSize(width: size.0, height: size.1)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch type {
        case .Demo:
            return getDemoCell(at: index)
        case .HouseSuggestion:
            return getHouseSuggestionCell(at: index)
        case .TradeSellingItems:
            return getTradeSellingItemsCell(at: index)
        case .Reviews:
            return getHouseReviewCell(at: index)
        case .Images:
            return getImageCell(at: index)
        }
    }

    override func didSelectItem(at index: Int) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        
        if let data = data as? HouseSuggestionModel {
            let vc = ApartmentSummaryVC()
            vc.houseId = data.houseId
            viewController?.navigationController?.pushViewController(vc, animated: true)
            let presentVC = TeamSummaryVC()
            presentVC.teamId = data.teamId
            DispatchQueue.main.async {
                generator.notificationOccurred(.success)
                self.viewController?.present(UINavigationController(rootViewController: presentVC), animated: true, completion: nil)
            }
            return
        }
    }

    override func didUpdate(to object: Any) {
        switch type {
        case .Demo:
            data = object as? ListDiffable
        case .HouseSuggestion:
            data = object as? HouseSuggestionModel
        case .TradeSellingItems:
            data = object as? TradeSellingItemModel
        case .Reviews:
            data = object as? HouseReviewModel
        case .Images:
            data = object as? ListDiffable
        }
    }

    private func getSize() -> (CGFloat, CGFloat) {
        switch type {
        case .Demo:
            return (100, 100)
        case .HouseSuggestion:
            let width = Constants.screenWidth - cellSpacing * 6
            let height = collectionContext?.containerSize.height ?? 0
            return (width, height)
        case .TradeSellingItems:
            let width = Constants.screenWidth / 2 - 40
            return (width, width)
        case .Reviews:
            let width = Constants.screenWidth - cellSpacing * 6
            let height = collectionContext?.containerSize.height ?? 0
            return (width, height)
        case .Images:
            let width = collectionContext?.containerSize.width ?? 0
            let height = collectionContext?.containerSize.height ?? 0
            return (width, height)
        }
    }
}

extension EmbeddedSectionController: ListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        if let data = data, let url = data as? String {
            setImage(url)
            return
        }
        guard let data = data, let photo = data as? PhotoShowable, let url = photo.getFirstPhotoURL() else { return }
        setImage(url)
    }

    private func setImage(_ url: String) {
        AlamofireService.shared.downloadImage(at: url, downloadProgress: nil) { (image, error) in
            if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? ImageSettable {
                cell.setImage(image)
            }
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}
}

extension EmbeddedSectionController {
    private func getDemoCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: CenterLabelCell.self, for: self, at: index) as? CenterLabelCell, let data = data, let cellData = data as? Int else {
            fatalError()
        }
        let value = cellData
        cell.text = "\(value + 1)"
        cell.backgroundColor = Color.theme
        return cell
    }

    private func getTradeSellingItemsCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: TradeSellingItemsCell.self, for: self, at: index) as? TradeSellingItemsCell, let data = data, let cellData = data as? TradeSellingItemModel else {
            fatalError()
        }
        cell.titleLabel.text = cellData.title
        cell.priceLabel.text = "$\(cellData.price.addComma()!)"
        cell.viewsLabel.text = "\(cellData.views.addComma()!) views"
        return cell
    }

    private func getHouseSuggestionCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HouseSuggestionCell.self, for: self, at: index) as? HouseSuggestionCell, let data = data, let cellData = data as? HouseSuggestionModel else {
            fatalError()
        }
        cell.titleLabel.text = cellData.title
        cell.subtitleLabel.text = cellData.preference.getTextForm()
        cell.durationLabel.text = cellData.duration
        cell.createGroup(occupiedCount: cellData.occupiedCount, size: cellData.groupSize)
        return cell
    }

    private func getHouseReviewCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HouseReviewCell.self, for: self, at: index) as? HouseReviewCell, let data = data, let cellData = data as? HouseReviewModel else {
            fatalError()
        }
        cell.usernameLabel.text = cellData.username
        cell.titleLabel.text = cellData.title
        cell.dateLabel.text = cellData.readableDate()
        cell.detailLabel.text = cellData.detail
        cell.setStarRating(rating: cellData.starRating)
        let role = DataStore.shared.user?.userType ?? .Tenant
        cell.setOwnerComment(cellData.ownerComment, role: role)
        return cell
    }

    private func getImageCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ImageCell.self, for: self, at: index) as? ImageCell else {
            fatalError()
        }
        return cell
    }
}
