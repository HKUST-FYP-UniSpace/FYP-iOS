//
//  TradeDetailSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 28/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class TradeDetailSectionController: ListSectionController {

    var contentOffset: CGFloat = 0
    private var tradeItemId: Int?
    private var cellSpacing: CGFloat = 10

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController)
        return adapter
    }()

    override func numberOfItems() -> Int {
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        switch index {
        case 0:
            return CGSize(width: collectionContext!.containerSize.width, height: 40)
        default:
            return CGSize.zero
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        switch index {
        case 0:
            let cell = collectionContext?.dequeueReusableCell(of: ButtonCell.self, for: self, at: index)
            if let cell = cell as? ButtonCell {
                cell.delegate = self
                cell.button.setTitle("Message Owner", for: .normal)
                return cell
            }
            fatalError()
        default:
            fatalError()
        }
    }

    override func didUpdate(to object: Any) {
        let object = object as? TradeFeaturedModel
        tradeItemId = object?.id
    }
}

extension TradeDetailSectionController: ButtonCellDelegate {
    func buttonCell(pressedButton sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        guard let tradeItemId = tradeItemId else { return }
        generator.notificationOccurred(.success)
        let vc = CreateMessageGroupVC(.Trade, tradeItemId: tradeItemId)
        adapter.viewController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}
