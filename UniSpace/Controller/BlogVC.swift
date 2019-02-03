//
//  BlogVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class BlogVC: SingleSectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Blog"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.view.backgroundColor = .white
    }

    override func loadData() {
        super.loadData()
        DataStore.shared.getBlogSummaries { (models, error) in
            self.data = models
            self.adapter.reloadData(completion: nil)
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? BlogCell, let object = object as? BlogSummaryModel else { return }
            cell.titleLabel.text = object.title.uppercased()
            cell.subTitleLabel.text = object.subTitle

            AlamofireService.shared.downloadImageData(at: object.photoURL, downloadProgress: nil) { (data, error) in
                guard let data = data else { return }
                cell.setImage(image: UIImage(data: data))
            }
        }
        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            let cellSpacing: CGFloat = 20
            return CGSize(width: context.containerSize.width - cellSpacing * 2, height: 420)
        }

        let sectionController = ListSingleSectionController(cellClass: BlogCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
        sectionController.selectionDelegate = self
        sectionController.inset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        return sectionController
    }
}
