//
//  NotificationVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class NotificationVC: SingleSectionViewController {

    let options = UISegmentedControl(items: ["Chat", "Calendar", "Notification"])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notification"
        tabBarItem = UITabBarItem(title: "Message", image: UIImage(named: "Message"), tag: 3)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.view.backgroundColor = .white
        setupSegControl()
    }

    override func loadData() {
        super.loadData()
        DataStore.shared.getNotificationSummaries { (models, error) in
            self.data = models
            self.adapter.reloadData(completion: nil)
        }
    }

    private func setupSegControl() {
        let font = UIFont.boldSystemFont(ofSize: 14)
        options.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        options.tintColor = Color.theme
        options.selectedSegmentIndex = 2
        options.addTarget(self, action: #selector(handleScopeChange), for: .valueChanged)
        navigationItem.titleView = options
        options.translatesAutoresizingMaskIntoConstraints = false
        options.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    @objc func handleScopeChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            navigationController?.setViewControllers([MessageVC()], animated: false)
        case 1:
            navigationController?.setViewControllers([CalendarVC()], animated: false)
        default:
            return
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? NotificationCell, let object = object as? NotificationSummaryModel else { return }
            cell.titleLabel.text = object.title
            cell.subTitleLabel.text = object.subTitle
            cell.timeLabel.text = object.readableTime()

            AlamofireService.shared.downloadImageData(at: object.photoURL, downloadProgress: nil) { (data, error) in
                guard let data = data else { return }
                cell.setImage(image: UIImage(data: data))
            }
        }
        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return CGSize(width: context.containerSize.width, height: 80)
        }

        let sectionController = ListSingleSectionController(cellClass: NotificationCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
        sectionController.selectionDelegate = self
        return sectionController
    }
}
