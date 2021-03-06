//
//  CalendarVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 3/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class CalendarVC: MasterVC, ListAdapterDataSource {

    private let options = UISegmentedControl(items: ["Chat", "Calendar", "Notification"])
    private var months = [Month]()
    private var date = Date()

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar"
        tabBarItem = UITabBarItem(title: "Message", image: UIImage(named: "Message"), tag: 3)
        setupSegControl()

        let item = UIBarButtonItem(image: UIImage(named: "Change"), style: .plain, target: self, action: #selector(changeButton))
        navigationItem.rightBarButtonItem = item

        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLargeTitle()
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

    @objc func changeButton(_ sender: UIButton) {
        let currentMonth = getMonth(date)
        let alert = UIAlertController(title: "Change Month", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: getMonthName(currentMonth-1), style: .default, handler: { _ in
            guard let newDate = self.nextMonth(self.date, step: -1) else { return }
            self.date = newDate
            self.loadData()
        }))
        alert.addAction(UIAlertAction(title: getMonthName(currentMonth+1), style: .default, handler: { _ in
            guard let newDate = self.nextMonth(self.date, step: 1) else { return }
            self.date = newDate
            self.loadData()
        }))

        self.present(alert, animated: true)
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

    override func loadData() {
        let currentYear = getYear(date)
        let currentMonth = getMonth(date)

        guard let days = DateManager.shared.numberOfDays(year: currentYear, month: currentMonth) else { return }
        let name = getMonthName(currentMonth) + " \(currentYear)"
        DataStore.shared.getCalendarSummaries(year: currentYear, month: currentMonth) { (models, error) in
            guard let models = models else { return }
            var appointments: [Int: [NSString]] = [:]
            for model in models {
                var details: [NSString] = []
                let modelData = model.data.sorted(by: { $0.startTime < $1.startTime })
                for data in modelData {
                    let info = "\(data.startTime) \(data.appointment)"
                    details.append(info as NSString)
                }
                appointments[model.date] = details
            }

            self.months = [Month(name: name, days: days, appointments: appointments)]
            self.adapter.reloadData(completion: nil)
        }
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

extension CalendarVC {
    private func nextMonth(_ date: Date, step: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: step, to: date)
    }

    private func getMonthName(_ month: Int) -> String {
        var currentMonth = month
        while currentMonth > 12 { currentMonth -= 12 }
        while currentMonth < 1 { currentMonth += 12 }
        return DateFormatter().monthSymbols[currentMonth - 1]
    }

    private func getMonth(_ date: Date) -> Int {
        return Calendar.current.component(.month, from: date)
    }

    private func getYear(_ date: Date) -> Int {
        return Calendar.current.component(.year, from: date)
    }
}
