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
        DataStore.shared.getBlogDetail(blogId: 0, completion: completion)
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? BlogDetailCell, let object = object as? BlogSummaryModel else { return }
            cell.titleLabel.text = object.title
            cell.subtitleLabel.text = object.subtitle
            cell.detailLabel.text = object.detail
            cell.setImage(image: nil)

            AlamofireService.shared.downloadImageData(at: object.photoURL, downloadProgress: nil) { (data, error) in
                guard let data = data else { return }
                cell.setImage(image: UIImage(data: data))
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
