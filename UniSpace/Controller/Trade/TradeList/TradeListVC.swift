//
//  TradeListVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

enum TradeListType {
    case Result
    case Featured
    case Saved

    var text: String {
        switch self {
        case .Result:
            return "Result"
        case .Featured:
            return "Featured"
        case .Saved:
            return "Saved"
        }
    }
}

final class TradeListVC: SingleSectionViewController {

    var type: TradeListType
    var filter = TradeFilterModel()

    init(_ type: TradeListType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.title == nil { self.title = type.text }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    override func loadData() {
        super.loadData()
        switch type {
        case .Result:
            DataStore.shared.getTradeList(filter: filter, completion: completion)
        case .Featured:
            DataStore.shared.getTradeFeatured(completion: completion)
        case .Saved:
            DataStore.shared.getTradeSaved(completion: completion)
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? TradeListCell, let object = object as? TradeFeaturedModel else { return }
            cell.titleLabel.text = object.title
            cell.locationLabel.text = object.location
            cell.priceLabel.text = "$\(object.price.addComma()!)"
            cell.statusLabel.text = object.status
            cell.subtitleLabel.text = object.detail

            AlamofireService.shared.downloadImageData(at: object.photoURL, downloadProgress: nil) { (data, error) in
                guard let data = data else { return }
                cell.setImage(image: UIImage(data: data))
            }
        }
        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return CGSize(width: context.containerSize.width, height: 120)
        }

        let sectionController = ListSingleSectionController(cellClass: TradeListCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
        sectionController.selectionDelegate = self
        return sectionController
    }

    override func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        if let data = object as? HouseListModel {
            let vc = ApartmentSummaryVC()
            vc.houseId = data.id
            adapter.viewController?.navigationController?.pushViewController(vc, animated: true)
            return
        }
    }
}
