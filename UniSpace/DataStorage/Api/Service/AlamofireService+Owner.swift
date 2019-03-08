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
        completion(nil, nil)
    }

}
