//
//  BlogDetailVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class BlogDetailVC: SingleSectionViewController {

    var id: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    override func loadData() {
        super.loadData()
        guard let id = id else { return }
        DataStore.shared.getBlogDetail(blogId: id, completion: completion)
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? BlogDetailCell, let object = object as? BlogSummaryModel else { return }
            cell.titleLabel.text = object.title
            cell.subtitleLabel.text = object.subtitle
            cell.detailLabel.text = object.detail

            AlamofireService.shared.downloadImage(at: object.photoURL, downloadProgress: nil) { (image, error) in
                cell.setImage(image)
            }
        }
        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return CGSize(width: context.containerSize.width, height: 1400)
        }

        let sectionController = ListSingleSectionController(cellClass: BlogDetailCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
        sectionController.selectionDelegate = self
        return sectionController
    }

}
