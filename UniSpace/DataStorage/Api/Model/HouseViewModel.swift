//
//  HouseViewModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 6/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation
import IGListKit

class HouseViewModel: Decodable, ListDiffable {

    var id: Int = DataStore.shared.randomInt(length: 8)
    var titleView: HouseListModel? = nil
    var teams: [HouseTeamSummaryModel] = []
    var reviews: [HouseReviewModel] = []

    init() {}

    init(titleView: HouseListModel?, teams: [HouseTeamSummaryModel], reviews: [HouseReviewModel]) {
        id = DataStore.shared.randomInt(length: 8)
        self.titleView = titleView
        self.teams = teams
        self.reviews = reviews
    }

    enum CodingKeys: String, CodingKey {
        case id
        case titleView
        case teams
        case reviews
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &titleView, type: HouseListModel?.self, forKey: .titleView)
        decode(container, &teams, type: [HouseTeamSummaryModel].self, forKey: .teams)
        decode(container, &reviews, type: [HouseReviewModel].self, forKey: .reviews)
    }

    private func decode<T>(_ container: KeyedDecodingContainer<CodingKeys>, _ variable: inout T, type: T.Type, forKey key: CodingKeys) where T: Decodable {
        if let _variable = try? container.decode(type, forKey: key) {
            variable = _variable
        }
    }

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? HouseViewModel else { return false }
        return self.id == object.id
    }

}
