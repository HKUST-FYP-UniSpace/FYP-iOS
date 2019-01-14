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
}

final class EmbeddedSectionController: ListSectionController {

    var cellSpacing: CGFloat = 10
    private var number: Int?
    private var type: EmbeddedSectionType

    init(_ type: EmbeddedSectionType) {
        self.type = type
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
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
        }
    }

    override func didUpdate(to object: Any) {
        number = object as? Int
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
        }
    }
}

extension EmbeddedSectionController: ListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        let size = getSize()
        let url = Constants.dummyPhotoURL(size.0)
        AlamofireService.shared.downloadImageData(at: url, downloadProgress: nil) { (data, error) in
            guard let data = data else { return }
            if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? ImageSettable {
                cell.setImage(image: UIImage(data: data))
            }
        }
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}
}

extension EmbeddedSectionController {
    private func getDemoCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: CenterLabelCell.self, for: self, at: index) as? CenterLabelCell else {
            fatalError()
        }
        let value = number ?? 0
        cell.text = "\(value + 1)"
        cell.backgroundColor = Color.theme
        return cell
    }

    private func getTradeSellingItemsCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: TradeSellingItemsCell.self, for: self, at: index) as? TradeSellingItemsCell else {
            fatalError()
        }
        cell.titleLabel.text = ["Barcelona Chair", "Wassily Chair", "Brno Chair"].randomElement()
        cell.priceLabel.text = "$\((Int.random(in: 20..<100) * 100).addComma()!)"
        cell.viewsLabel.text = "\((Int.random(in: 0..<1000)).addComma()!) views"
        return cell
    }

    private func getHouseSuggestionCell(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: HouseSuggestionCell.self, for: self, at: index) as? HouseSuggestionCell else {
            fatalError()
        }
        cell.setImage(image: nil)
        cell.titleLabel.text = "Team Awesome"
        cell.subTitleLabel.text = "Boys / Pet-free / Casual drinker"
        cell.durationLabel.text = ["3 months", "6 months", "1 year", "2 years"].randomElement()
        return cell
    }
}
