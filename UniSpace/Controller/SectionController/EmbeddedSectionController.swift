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
        var width: CGFloat = 0
        var height: CGFloat = 0
        switch type {
        case .Demo:
            width = 100
            height = 100
        case .HouseSuggestion:
            width = Constants.screenWidth - cellSpacing * 6
            height = collectionContext?.containerSize.height ?? 0
        case .TradeSellingItems:
            width = Constants.screenWidth / 2 - 40
            height = width
        }
        return CGSize(width: width, height: height)
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
}

extension EmbeddedSectionController: ListWorkingRangeDelegate {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        guard let width = collectionContext?.containerSize.width else { return }
        let url = Constants.dummyPhotoURL(width)
        AlamofireService.shared.downloadImageData(at: url, downloadProgress: nil) { (data, error) in
            guard let data = data else { return }
            if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? HouseSuggestionCell {
                cell.setImage(image: UIImage(data: data))
            } else if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? TradeSellingItemsCell {
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
