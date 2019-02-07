//
//  ApartmentListVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 4/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

enum ApartmentListType {
    case Result
    case Saved

    var text: String {
        switch self {
        case .Result:
            return "Result"
        case .Saved:
            return "Saved"
        }
    }
}

final class ApartmentListVC: SingleSectionViewController {

    var type: ApartmentListType

    init(_ type: ApartmentListType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = type.text
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
            DataStore.shared.getHouseList { (models, error) in
                self.data = models
                self.adapter.reloadData(completion: nil)
            }

        case .Saved:
            DataStore.shared.getHouseSaved { (models, error) in
                self.data = models
                self.adapter.reloadData(completion: nil)
            }
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? HouseListCell, let object = object as? HouseListModel else { return }
            cell.titleLabel.text = object.title
            cell.starRatings.setStarRating(rating: Int.random(in: 0..<6))
            cell.priceLabel.text = "$\(object.price.addComma()!) pcm"
            cell.sizeLabel.text = "\(object.size.addComma()!) sq. ft."
            cell.subtitleLabel.text = object.subtitle

            AlamofireService.shared.downloadImageData(at: object.photoURL, downloadProgress: nil) { (data, error) in
                guard let data = data else { return }
                cell.setImage(image: UIImage(data: data))
            }
        }
        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return CGSize(width: context.containerSize.width, height: 120)
        }

        let sectionController = ListSingleSectionController(cellClass: HouseListCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
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
