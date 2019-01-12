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
    case Blog
}

final class GridSectionController: ListSectionController {

    private var number: Int?
    private var type: GridType
    private var itemCount: Int
    private var cellSpacing: CGFloat = 20

    init(_ type: GridType) {
        self.type = type
        switch type {
        case .HouseSaved, .TradeFeatured:
            itemCount = 4
        case .TradeSaved:
            itemCount = 3
        case .Blog:
            itemCount = 1
        }
        super.init()

        self.minimumInteritemSpacing = 20
        self.minimumLineSpacing = 20
        self.inset = UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
        workingRangeDelegate = self
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let containerWidth = collectionContext?.containerSize.width ?? 0
        if type == .Blog {
            return CGSize(width: containerWidth - cellSpacing * 2, height: 420)
        }
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
            cell.setStarRating(rating: Int.random(in: 0..<6))
            cell.titleLabel.text = "Clear Water Bay Deluxe"
            cell.priceLabel.text = "$\((Int.random(in: 50..<200) * 100).addComma()!) pcm"
            cell.sizeLabel.text = "\(Int.random(in: 500..<1500).addComma()!) sq. ft."
            return cell

        case .TradeFeatured, .TradeSaved:
            guard let cell = collectionContext?.dequeueReusableCell(of: TradeFeaturedCell.self, for: self, at: index) as? TradeFeaturedCell else {
                fatalError()
            }
            cell.setImage(image: nil)
            cell.titleLabel.text = ["Barcelona Chair", "Wassily Chair", "Brno Chair"].randomElement()
            cell.priceLabel.text = "$\((Int.random(in: 20..<100) * 100).addComma()!)"
            cell.statusLabel.text = ["NEW", ""].randomElement()
            cell.detailLabel.text = "Designed by Marcel Breuer, it is an iconic Bauhaus style chair"
            return cell

        case .Blog:
            guard let cell = collectionContext?.dequeueReusableCell(of: BlogCell.self, for: self, at: index) as? BlogCell else {
                fatalError()
            }
            cell.setImage(image: nil)
            cell.titleLabel.text = "Get Started".uppercased()
            cell.subTitleLabel.text = ["How to Find the Perfect Apartment", "How to Survive Apocalpse"].randomElement()
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
                } else if let cell = self.collectionContext?.cellForItem(at: index, sectionController: self) as? BlogCell {
                    cell.setImage(image: UIImage(data: data))
                }
            }
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}
}
