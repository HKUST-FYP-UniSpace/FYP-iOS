//
//  TestService+Owner.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

extension TestService: OwnerService {

    func getOwnerHouseSummary(completion: @escaping ([OwnerHouseSummaryModel]?, Error?) -> Void) {
        var summaries: [OwnerHouseSummaryModel]? = []
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestOwnerHouseSummaryModel().toModel()) }
        summaries?.sort(by: { $0.createTime > $1.createTime })
        delay { completion(summaries, nil) }
    }

    func getOwnerTeamsSummary(houseId: Int, completion: @escaping (OwnerTeamsModel?, Error?) -> Void) {
        var teams: [HouseTeamSummaryModel] = []
        var reviews: [HouseReviewModel] = []
        for _ in 0..<Int.random(in: (1..<10)) { teams.append(TestHouseTeamSummaryModel().toModel()) }
        for _ in 0..<Int.random(in: (6..<10)) { reviews.append(TestHouseReviewModel().toModel()) }
        reviews.sort(by: { $0.date > $1.date })
        let model = OwnerTeamsModel(teams: teams, reviews: reviews)
        delay { completion(model, nil) }
    }

    func replyReivew(reviewId: Int, comment: String, completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

    func getHouseData(houseId: Int, filter: ChartFilterOptions, completion: @escaping (ChartDataListModel?, Error?) -> Void) {
        let data: ChartDataListModel? = ChartDataListModel()
        for i in 0..<filter.dataCount {
            let newData = TestChartDataModel()
            newData.setup(order: i)
            data?.targetViews.append(newData.toModel())
            newData.reRandomize()
            data?.othersViews.append(newData.toModel())
            newData.reRandomize()
            data?.targetBookmarks.append(newData.toModel())
            newData.reRandomize()
            data?.othersBookmarks.append(newData.toModel())
        }
        delay { completion(data, nil) }
    }

    func createHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

    func editHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

    func changeHouseStatus(houseId: Int, status: HouseStatus, completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

}
