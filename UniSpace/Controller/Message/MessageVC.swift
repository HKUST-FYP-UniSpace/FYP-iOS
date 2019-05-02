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

        let item = UIBarButtonItem(image: UIImage(named: "Assist"), style: .plain, target: self, action: #selector(handleAssist))
        navigationItem.rightBarButtonItem = item
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLargeTitle()
        loadData()
    }

    @objc func handleAssist(sender: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
        let vc = CreateMessageGroupVC(.Admin)
        adapter.viewController?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }

    override func loadData() {
        super.loadData()
        DataStore.shared.getMessageSummaries(completion: completion)
    }

    override func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        if let data = object as? MessageSummaryModel {
            let messageGroup = RealmMessageGroup(id: data.id, name: data.title, timestamp: data.time)
            RealmService.shared.persist(messageGroup)
            let vc = MessageConversationVC()
            vc.chatInfo = data
            adapter.viewController?.navigationController?.pushViewController(vc, animated: true)
            return
        }
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

            let url = object.messageType != .Admin ? object.photoURL : "http://facebookfplus.com/upload/images/600_97d118b7a6f8f87d18f7b1385ea7665e.png"
            AlamofireService.shared.downloadImage(at: url, downloadProgress: nil) { (image, error) in
                cell.setImage(image)
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
