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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        loadData()
    }

    override func loadData() {
        super.loadData()
        DataStore.shared.getBlogSummaries(completion: completion)
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? BlogCell, let object = object as? BlogSummaryModel else { return }
            cell.titleLabel.text = object.title.uppercased()
            cell.subtitleLabel.text = object.subtitle

            AlamofireService.shared.downloadImage(at: object.photoURL, downloadProgress: nil) { (image, error) in
                cell.setImage(image)
            }
        }
        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            let cellSpacing: CGFloat = 20
            return CGSize(width: context.containerSize.width - cellSpacing * 2, height: 426)
        }

        let sectionController = ListSingleSectionController(cellClass: BlogCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
        sectionController.selectionDelegate = self
        sectionController.inset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
        return sectionController
    }

    override func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        if let data = object as? BlogSummaryModel {
            let vc = BlogDetailVC()
            vc.id = data.id
            adapter.viewController?.navigationController?.pushViewController(vc, animated: true)
            return
        }
    }
}
