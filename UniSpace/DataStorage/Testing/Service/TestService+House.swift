//
//  TestService+House.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

extension TestService: HouseService {
    
    func getHouseSuggestions(userId: Int, completion: @escaping ([HouseSuggestionModel]?, Error?) -> Void) {
        var summaries: [HouseSuggestionModel]? = []
        for _ in 0..<Int.random(in: (2..<10)) { summaries?.append(TestHouseSuggestionModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getHouseSaved(userId: Int, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        var summaries: [HouseListModel]? = []
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestHouseListModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getHouseList(userId: Int, filter: HouseFilterModel, completion: @escaping ([HouseListModel]?, Error?) -> Void) {
        var summaries: [HouseListModel]? = []
        for _ in 0..<Int.random(in: (5..<30)) { summaries?.append(TestHouseListModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getHouseView(houseId: Int, completion: @escaping (HouseViewModel?, Error?) -> Void) {
        var teams: [HouseTeamSummaryModel] = []
        var reviews: [HouseReviewModel] = []
        for _ in 0..<Int.random(in: (1..<5)) { teams.append(TestHouseTeamSummaryModel().toModel()) }
        for _ in 0..<Int.random(in: (6..<10)) { reviews.append(TestHouseReviewModel().toModel()) }
        reviews.sort(by: { $0.date > $1.date })
        let model = HouseViewModel(titleView: TestHouseListModel().toModel(), teams: teams, reviews: reviews)
        delay { completion(model, nil) }
    }

    func getTeamView(teamId: Int, completion: @escaping (TeamSummaryViewModel?, Error?) -> Void) {
        var teamMembers: [TeamMemberModel] = []
        teamMembers.append(TestTeamMemberModel(name: "Jon Stewart", role: .Leader).toModel())
        teamMembers.append(TestTeamMemberModel(name: "John Oliver", role: .Member).toModel())
        teamMembers.append(TestTeamMemberModel(name: "Stephen Colbert", role: .Member).toModel())
        let model = TeamSummaryViewModel(teamView: TestHouseTeamSummaryModel().toModel(), teamMembers: teamMembers)
        delay { completion(model, nil) }
    }

    func bookmarkHouse(userId: Int, houseId: Int, completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

    func changePreference(userId: Int, preference: PreferenceModel, completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

    func createTeam(userId: Int, houseId: Int, model: HouseTeamSummaryModel, image: UIImage, completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

    func joinTeam(userId: Int, teamId: Int, completion: SendRequestResult?) {
        delay { completion?(nil, nil) }
    }

}
