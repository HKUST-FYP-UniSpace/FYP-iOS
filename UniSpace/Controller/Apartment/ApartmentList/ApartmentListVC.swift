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
        self.title = type.text
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

extension ApartmentListVC: ApartmentFilterVCDelegate {
    func updateFilter(filter: HouseFilterModel?) {
        if let filter = filter { self.filter = filter }
    }
}
