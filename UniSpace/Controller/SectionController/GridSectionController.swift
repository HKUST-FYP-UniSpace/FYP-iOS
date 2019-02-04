//
//  GridSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

enum GridType {
    case HouseSaved
    case TradeFeatured
    case TradeSaved
}

final class GridSectionController: ListSectionController {

    private var data: [ListDiffable]?
    private var type: GridType
    private var cellSpacing: CGFloat = 20

    init(_ type: GridType) {
        self.type = type
        super.init()

        self.minimumInteritemSpacing = 20
        self.minimumLineSpacing = 20
        self.inset = UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
        workingRangeDelegate = self
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let size = getSize()
        return CGSize(width: size.0, height: size.1)
    }

    override func numberOfItems() -> Int {
        let count = data?.count ?? 0
        return count > 4 ? 4 : count
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let data = data else { fatalError() }
        switch type {
        case .HouseSaved:
            guard let cell = collectionContext?.dequeueReusableCell(of: HouseSavedCell.self, for: self, at: index) as? HouseSavedCell, let cellData = data[index] as? HouseSavedModel else {
                fatalError()
            }
            cell.setImage(image: nil)
            cell.setStarRating(rating: cellData.starRating)
            cell.titleLabel.text = cellData.title
            cell.priceLabel.text = "$\(cellData.price.addComma()!) pcm"
            cell.sizeLabel.text = "\(cellData.size.addComma()!) sq. ft."
            return cell

        case .TradeFeatured, .TradeSaved:
            guard let cell = collectionContext?.dequeueReusableCell(of: TradeFeaturedCell.self, for: self, at: index) as? TradeFeaturedCell, let cellData = data[index] as? TradeFeaturedModel else {
                fatalError()
            }
            cell.setImage(image: nil)
            cell.titleLabel.text = cellData.title
            cell.priceLabel.text = "$\(cellData.price.addComma()!)"
            cell.statusLabel.text = cellData.status
            cell.detailLabel.text = cellData.detail
            return cell
        }
    }

    override func didSelectItem(at index: Int) {
        log.debug("Grid Section Controller", context: "Selected index: \(index)")
    }

    override func didUpdate(to object: Any) {
        switch type {
        case .HouseSaved:
            let house = object as? HouseHomepageModel
            data = house?.saved

        case .TradeFeatured:
            let trade = object as? TradeHomepageModel
            data = trade?.featured

        case .TradeSaved:
            let trade = object as? TradeHomepageModel
            data = trade?.saved
        }
    }

    private func getSize() -> (CGFloat, CGFloat) {
        let containerWidth = collectionContext?.containerSize.width ?? 0
        let width = containerWidth / 2 - cellSpacing * 2
        let height = type == .HouseSaved ? width : width + cellSpacing
        return (width, height)
    }
}

extension GridSectionController: ListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        guard let data = data else { return }
        for index in (0..<data.count) {
            guard let photo = data[index] as? PhotoShowable else { continue }
            let url = photo.photoURL
            AlamofireService.shared.downloadImageData(at: url, downloadProgress: nil) { (data, error) in
                guard let data = data else { return }
                if let cell = self.collectionContext?.cellForItem(at: index, sectionController: self) as? ImageSettable {
                    cell.setImage(image: UIImage(data: data))
                }
            }
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}
}
