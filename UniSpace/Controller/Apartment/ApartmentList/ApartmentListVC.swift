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
    case History

    var text: String {
        switch self {
        case .Result: return "Result"
        case .Saved: return "Saved"
        case .History: return "Apartment History"
        }
    }
}

final class ApartmentListVC: SingleSectionViewController {

    var type: ApartmentListType
    var filter = HouseFilterModel()

    init(_ type: ApartmentListType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        self.title = type.text
        guard type == .Result else { return }
        let filterItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButton))
        navigationItem.rightBarButtonItem = filterItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLargeTitle()
    }

    @objc func filterButton(_ sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()

        let vc = ApartmentFilterVC()
        vc.filter = filter
        vc.delegate = self
        DispatchQueue.main.async {
            generator.notificationOccurred(.success)
            self.adapter.viewController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        }
    }

    override func loadData() {
        switch type {
        case .Result:
            DataStore.shared.getHouseList(filter: filter, completion: completion)
        case .Saved:
            DataStore.shared.getHouseSaved(completion: completion)
        case .History:
            DataStore.shared.getHouseHistory(completion: completion)
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? HouseListCell, let object = object as? HouseListModel else { return }
            cell.titleLabel.text = object.title
            cell.starRatings.setStarRating(rating: object.starRating)
            cell.priceLabel.text = "$\(object.price.addComma()!) pcm"
            cell.sizeLabel.text = "\(object.size.addComma()!) sq. ft."
            cell.subtitleLabel.text = object.subtitle

            guard let url = object.getFirstPhotoURL() else { return }
            AlamofireService.shared.downloadImage(at: url, downloadProgress: nil) { (image, error) in
                cell.setImage(image)
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

extension ApartmentListVC: ApartmentFilterVCDelegate {
    func updateFilter(filter: HouseFilterModel?) {
        if let filter = filter { self.filter = filter }
    }
}
