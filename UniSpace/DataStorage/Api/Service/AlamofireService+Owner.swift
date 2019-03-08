//
//  AlamofireService+Owner.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Alamofire

extension AlamofireService: OwnerService {

    func getOwnerStatsSummary(userId: Int, completion: @escaping ([OwnerStatsSummaryModel]?, Error?) -> Void) {
        get(at: .getOwnerStatsSummary()).responseJSON { (res: DataResponse<Any>) in
            var result: [OwnerStatsSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([OwnerStatsSummaryModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

}
