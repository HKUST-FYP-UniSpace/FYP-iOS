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

    private var number: Int?
    private var type: GridType
    private var itemCount: Int
    private var cellSpacing: CGFloat = 20

    init(_ type: GridType) {
        self.type = type
        itemCount = type == .TradeSaved ? 3 : 4
        super.init()

        self.minimumInteritemSpacing = 20
        self.minimumLineSpacing = 20
        self.inset = UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
        workingRangeDelegate = self
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let containerWidth = collectionContext?.containerSize.width ?? 0
        let width = containerWidth / 2 - cellSpacing * 2
        let height = type == .HouseSaved ? width : width + cellSpacing
        return CGSize(width: width, height: height)
    }

    override func numberOfItems() -> Int {
        return itemCount
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch type {
        case .HouseSaved:
            guard let cell = collectionContext?.dequeueReusableCell(of: HouseSavedCell.self, for: self, at: index) as? HouseSavedCell else {
                fatalError()
            }
            cell.setImage(image: nil)
            cell.setStarRating(rating: 4)
            cell.titleLabel.text = "Clear Water Bay Deluxe"
            cell.priceLabel.text = "$12,000 pcm"
            cell.sizeLabel.text = "689 sq. ft."
            return cell

        case .TradeFeatured, .TradeSaved:
            guard let cell = collectionContext?.dequeueReusableCell(of: TradeFeaturedCell.self, for: self, at: index) as? TradeFeaturedCell else {
                fatalError()
            }
            cell.setImage(image: nil)
            cell.titleLabel.text = "Wassily Chair"
            cell.priceLabel.text = "$3,000"
            cell.statusLabel.text = "NEW"
            cell.detailLabel.text = "Designed by Marcel Breuer, it is an iconic Bauhaus style chair"
            return cell
        }
    }

    override func didUpdate(to object: Any) {
        number = object as? Int
    }
}

extension GridSectionController: ListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        guard let width = collectionContext?.containerSize.width else { return }
        let indexes = (0..<itemCount).map { $0 }
        for index in indexes {
            let url = Constants.dummyPhotoURL(width)
            AlamofireService.shared.downloadImageData(at: url, downloadProgress: nil) { (data, error) in
                guard let data = data else { return }
                if let cell = self.collectionContext?.cellForItem(at: index, sectionController: self) as? HouseSavedCell {
                    cell.setImage(image: UIImage(data: data))
                } else if let cell = self.collectionContext?.cellForItem(at: index, sectionController: self) as? TradeFeaturedCell {
                    cell.setImage(image: UIImage(data: data))
                }
            }
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}
}
