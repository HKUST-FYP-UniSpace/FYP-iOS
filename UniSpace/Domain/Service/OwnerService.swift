//
//  OwnerService.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

protocol OwnerService: class {

    func getOwnerHouseSummary(userId: Int, completion: @escaping (_ summaries: [OwnerHouseSummaryModel]?, _ error: Error?) -> Void)

    func getOwnerTeamsSummary(userId: Int, houseId: Int, completion: @escaping (_ model: OwnerTeamsModel?, _ error: Error?) -> Void)

}
