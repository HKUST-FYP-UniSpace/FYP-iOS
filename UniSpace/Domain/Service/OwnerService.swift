//
//  OwnerService.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

protocol OwnerService: class {

    func getOwnerHouseSummary(completion: @escaping (_ summaries: [OwnerHouseSummaryModel]?, _ error: Error?) -> Void)

    func getOwnerTeamsSummary(houseId: Int, completion: @escaping (_ model: OwnerTeamsModel?, _ error: Error?) -> Void)

    func replyReivew(reviewId: Int, comment: String, completion: SendRequestResult?)

    func getHouseData(houseId: Int, filter: ChartFilterOptions, completion: @escaping (_ data: ChartDataListModel?, _ error: Error?) -> Void)

    func createHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?)

    func editHouse(model: HouseListModel, images: [UIImage], completion: SendRequestResult?)

    func changeHouseStatus(houseId: Int, status: HouseStatus, completion: SendRequestResult?)

}
