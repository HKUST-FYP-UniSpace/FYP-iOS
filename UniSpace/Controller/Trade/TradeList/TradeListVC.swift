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
    case History

    var text: String {
        switch self {
        case .Result: return "Result"
        case .Featured: return "Featured"
        case .Saved: return "Saved"
        case .History: return "Trade History"
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
        navigationController?.navigationBar.isHidden = false
        if self.title == nil { self.title = type.text }
        guard type == .Result else { return }
        let filterItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButton))
        navigationItem.rightBarButtonItem = filterItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLargeTitle()
        loadData()
    }

    @objc func filterButton(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()

        let vc = TradeFilterVC()
        vc.filter = filter
        vc.delegate = self
        generator.notificationOccurred(.success)
        self.adapter.viewController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
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
        case .History:
            DataStore.shared.getTradeHistory(completion: completion)
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? TradeListCell, let object = object as? TradeFeaturedModel else { return }
            cell.titleLabel.text = object.title
            cell.locationLabel.text = object.location
            cell.priceLabel.text = "$\(object.price.addComma()!)"
            cell.statusLabel.text = self.type == .History ? object.transactionType.uppercased() : object.status
            cell.subtitleLabel.text = object.detail

            guard let url = object.getFirstPhotoURL() else { return }
            AlamofireService.shared.downloadImage(at: url, downloadProgress: nil) { (image, error) in
                cell.setImage(image)
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
        if let data = object as? TradeFeaturedModel {
            let vc = TradeDetailVC()
            vc.tradeItemId = data.id
            adapter.viewController?.navigationController?.pushViewController(vc, animated: true)
            return
        }
    }
}

extension TradeListVC: TradeFilterVCDelegate {
    func updateFilter(filter: TradeFilterModel?) {
        if let filter = filter { self.filter = filter }
    }
}
