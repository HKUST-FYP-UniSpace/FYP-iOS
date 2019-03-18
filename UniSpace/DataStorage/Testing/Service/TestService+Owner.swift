//
//  TestService+Owner.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: OwnerService {

    func getOwnerHouseSummary(userId: Int, completion: @escaping ([OwnerHouseSummaryModel]?, Error?) -> Void) {
        var summaries: [OwnerHouseSummaryModel]? = []
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestOwnerHouseSummaryModel().toModel()) }
        summaries?.sort(by: { $0.createTime > $1.createTime })
        delay { completion(summaries, nil) }
    }

    func getOwnerTeamsSummary(userId: Int, houseId: Int, completion: @escaping (OwnerTeamsModel?, Error?) -> Void) {
        var arrangingTeams: [HouseTeamSummaryModel] = []
        var formingTeams: [HouseTeamSummaryModel] = []
        var reviews: [HouseReviewModel] = []
        for _ in 0..<Int.random(in: (1..<5)) { arrangingTeams.append(TestHouseTeamSummaryModel().toModel()) }
        for _ in 0..<Int.random(in: (1..<5)) { formingTeams.append(TestHouseTeamSummaryModel().toModel()) }
        for _ in 0..<Int.random(in: (6..<10)) { reviews.append(TestHouseReviewModel().toModel()) }
        reviews.sort(by: { $0.date > $1.date })
        let model = OwnerTeamsModel(arrangingTeams: arrangingTeams, formingTeams: formingTeams, reviews: reviews)
        delay { completion(model, nil) }
    }

}
