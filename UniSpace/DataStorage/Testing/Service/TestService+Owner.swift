//
//  TestService+Owner.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: OwnerService {

    func getOwnerStatsSummary(userId: Int, completion: @escaping ([OwnerStatsSummaryModel]?, Error?) -> Void) {
        var summaries: [OwnerStatsSummaryModel]? = []
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestOwnerStatsSummaryModel().toModel()) }
        summaries?.sort(by: { $0.createTime > $1.createTime })
        delay { completion(summaries, nil) }
    }

}
