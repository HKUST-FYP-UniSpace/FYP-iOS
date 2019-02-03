//
//  CalendarVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class CalendarVC: UIViewController, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
    )

    let options = UISegmentedControl(items: ["Chat", "Calendar", "Notification"])

    var months = [Month]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar"
        tabBarItem = UITabBarItem(title: "Message", image: UIImage(named: "Message"), tag: 3)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.view.backgroundColor = .white
        setupSegControl()
        loadData()

        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    private func setupSegControl() {
        let font = UIFont.boldSystemFont(ofSize: 14)
        options.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        options.tintColor = Color.theme
        options.selectedSegmentIndex = 1
        options.addTarget(self, action: #selector(handleScopeChange), for: .valueChanged)
        navigationItem.titleView = options
        options.translatesAutoresizingMaskIntoConstraints = false
        options.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    @objc func handleScopeChange(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            navigationController?.setViewControllers([MessageVC()], animated: false)
        case 2:
            navigationController?.setViewControllers([NotificationVC()], animated: false)
        default:
            return
        }
    }

    private func loadData() {
        let date = Date()
        let currentMonth = Calendar.current.component(.month, from: date)

        let month = Month(
            name: DateFormatter().monthSymbols[currentMonth - 1],
            days: 28,
            appointments: [
                2: ["Hair"],
                4: ["Nails"],
                7: ["Doctor appt", "Pick up groceries"],
                12: ["Call back the cable company", "Find a babysitter"],
                13: ["Dinner at The Smith"],
                17: ["Buy running shoes", "Buy a fitbit", "Start running"],
                20: ["Call mom"],
                21: ["Contribute to IGListKit"],
                25: ["Interview"],
                26: ["Quit running", "Buy ice cream"]
            ]
        )
        months.append(month)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return months
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return MonthSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }

}
