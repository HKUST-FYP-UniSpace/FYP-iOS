//
//  AlamofireService+Owner.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Alamofire

extension AlamofireService: OwnerService {

    func getOwnerHouseSummary(userId: Int, completion: @escaping ([OwnerHouseSummaryModel]?, Error?) -> Void) {
        get(at: .getOwnerStatsSummary()).responseJSON { (res: DataResponse<Any>) in
            var result: [OwnerHouseSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([OwnerHouseSummaryModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getOwnerTeamsSummary(userId: Int, houseId: Int, completion: @escaping (OwnerTeamsModel?, Error?) -> Void) {
        
    }

}
