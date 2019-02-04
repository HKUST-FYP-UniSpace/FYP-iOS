//
//  ApartmentListVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 4/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class ApartmentListVC: SingleSectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Results"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.view.backgroundColor = .white
    }

    override func loadData() {
        super.loadData()
        DataStore.shared.getHouseSaved { (models, error) in
            self.data = models
            self.adapter.reloadData(completion: nil)
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? HouseListCell, let object = object as? HouseSavedModel else { return }
            cell.titleLabel.text = object.title
            cell.starRatings.setStarRating(rating: Int.random(in: 0..<6))
            cell.priceLabel.text = "$\(object.price.addComma()!) pcm"
            cell.sizeLabel.text = "\(object.size.addComma()!) sq. ft."
            cell.subtitleLabel.text = """
            It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way – in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.
            """

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
}
