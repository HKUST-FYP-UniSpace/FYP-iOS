//
//  MessageVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class MessageVC: SingleSectionViewController {

    let options = UISegmentedControl(items: ["Chat", "Calendar", "Notification"])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Message"
        tabBarItem = UITabBarItem(title: "Message", image: UIImage(named: "Message"), tag: 3)
        setupSegControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLargeTitle()
        loadData()
    }

    override func loadData() {
        super.loadData()
        DataStore.shared.getMessageSummaries(completion: completion)
    }

    private func setupSegControl() {
        let font = UIFont.boldSystemFont(ofSize: 14)
        options.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        options.tintColor = Color.theme
        options.selectedSegmentIndex = 0
        options.addTarget(self, action: #selector(handleScopeChange), for: .valueChanged)
        navigationItem.titleView = options
        options.translatesAutoresizingMaskIntoConstraints = false
        options.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    @objc func handleScopeChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            navigationController?.setViewControllers([CalendarVC()], animated: false)
        case 2:
            navigationController?.setViewControllers([NotificationVC()], animated: false)
        default:
            return
        }
    }

    override func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? MessageCell, let object = object as? MessageSummaryModel else { return }
            cell.setup(messageType: object.messageType, newMessagesCount: object.unreadMessagesCount)
            cell.titleLabel.text = object.title
            cell.subtitleLabel.text = object.subtitle
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

        let sectionController = ListSingleSectionController(cellClass: MessageCell.self, configureBlock: configureBlock, sizeBlock: sizeBlock)
        sectionController.selectionDelegate = self
        return sectionController
    }
}
