//
//  OwnerChartVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 10/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Charts

fileprivate enum FilterOptions: Int, CaseIterable {
    case Week = 0
    case Month
    case Year

    var text: String {
        switch self {
        case .Week: return "This Week"
        case .Month: return "This Month"
        case .Year: return "This Year"
        }
    }

    var description: String {
        switch self {
        case .Week: return "This Week: daily count"
        case .Month: return "This Month: daily count"
        case .Year: return "This Year: monthly count"
        }
    }

    var dataCount: Int {
        switch self {
        case .Week: return 7
        case .Month: return 30
        case .Year: return 12
        }
    }
}

class ChartVC: MasterVC {

    var id: Int?
    var isHouse: Bool?
    var chartViews: [LineChartView]?
    private var option: FilterOptions = .Week

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialize()
    }

    private func initialize() {
        self.edgesForExtendedLayout = []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        title = "Stats"
        let item = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButton))
        navigationItem.rightBarButtonItem = item
        updateChart()
    }

    override func loadData() {
        guard let id = id, let isHouse = isHouse else { return }
        log.verbose("ChartVC", context: "isHouse: \(isHouse), id: \(id)")
        updateChart()
    }

    @objc func filterButton(_ sender: UIButton) {
        showActionSheet { (actionSheet) in
            actionSheet.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            self.present(actionSheet, animated: true, completion: nil)
        }
    }

    private func updateChart() {
        view.subviews.forEach { $0.removeFromSuperview() }
        chartViews = getChartViews()
        guard let chartViews = chartViews else { return }
        for chartView in chartViews {
            let data = dataWithCount(option.dataCount, range: 100)
            data.setValueFont(.systemFont(ofSize: 10, weight: .light))
            setupChart(chartView, data: data)
        }
    }

    private func showActionSheet(completion: @escaping (_ actionSheet: UIAlertController) -> ()) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        for option in FilterOptions.allCases {
            actionSheet.addAction(UIAlertAction(title: option.text, style: .default, handler: { _ in
                self.option = option
                self.loadData()
            }))
        }

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        completion(actionSheet)
    }

    private func setupChart(_ chart: LineChartView, data: LineChartData) {
        (data.getDataSetByIndex(0) as! LineChartDataSet).circleHoleColor = Color.theme
        (data.getDataSetByIndex(1) as! LineChartDataSet).circleHoleColor = .gray
        chart.backgroundColor = .clear

        chart.chartDescription?.enabled = true

        chart.dragEnabled = true
        chart.setScaleEnabled(true)
        chart.pinchZoomEnabled = true
        chart.drawBordersEnabled = false
        chart.setViewPortOffsets(left: 10, top: 0, right: 10, bottom: 0)

        let l = chart.legend
        l.form = .line
        l.font = .systemFont(ofSize: 14)
        l.textColor = .darkGray
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false

        chart.leftAxis.enabled = false
        chart.rightAxis.enabled = false
        chart.xAxis.enabled = false

        chart.data = data
//        chart.animate(xAxisDuration: 1)
    }

}

extension ChartVC {

    private func getChartViews() -> [LineChartView] {
        var chartViews: [LineChartView] = []
        var lastSubBottomAnchor: NSLayoutYAxisAnchor? = nil

        var descriptions: [String] = ["Views (\(option.description))", "Bookmarks (\(option.description))"]
        for i in 0..<descriptions.count {

            let titleLabel = StandardLabel(color: Color.theme, size: 16, isBold: true)
            view.addSubview(titleLabel)
            let topAnchor = lastSubBottomAnchor ?? view.topAnchor
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.wide).isActive = true
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Spacing.normal).isActive = true
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Spacing.normal).isActive = true
            titleLabel.sizeToFit()
            titleLabel.text = descriptions[i]

            let chartView = LineChartView(frame: .zero)
            chartView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(chartView)
            chartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
            chartView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
            chartView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
            chartView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            chartView.sizeToFit()

            chartViews.append(chartView)
            lastSubBottomAnchor = chartView.bottomAnchor
        }
        return chartViews
    }

    private func dataWithCount(_ count: Int, range: Int) -> LineChartData {
        let yVals1 = (0..<count).map { i -> ChartDataEntry in
            let val = Int.random(in: 0...range)
            return ChartDataEntry(x: Double(i), y: Double(val))
        }

        let yVals2 = (0..<count).map { i -> ChartDataEntry in
            let val = Int.random(in: 0...range)
            return ChartDataEntry(x: Double(i), y: Double(val))
        }

        let set1 = LineChartDataSet(values: yVals1, label: "Your Performance")
        set1.lineWidth = 2
        set1.circleRadius = 4
        set1.circleHoleRadius = 2
        set1.setColor(Color.theme)
        set1.setCircleColor(Color.theme)
        set1.highlightColor = Color.theme
        set1.drawValuesEnabled = true
        set1.valueFormatter = DefaultValueFormatter(decimals: 0)

        let set2 = LineChartDataSet(values: yVals2, label: "Average Performance")
        set2.lineWidth = 2
        set2.circleRadius = 4
        set2.circleHoleRadius = 2
        set2.setColor(.gray)
        set2.setCircleColor(.gray)
        set2.highlightColor = .gray
        set2.drawValuesEnabled = true
        set2.valueFormatter = DefaultValueFormatter(decimals: 0)

        return LineChartData(dataSets: [set1, set2])
    }
}
