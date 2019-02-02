//
//  TestGeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: GeneralService {
    
    func getUserProfile(userId: Int, completion: @escaping (UserProfileModel?, Error?) -> ()) {
        completion(nil, nil)
    }

    func getMessageSummaries(userId: Int, completion: @escaping ([MessageSummaryModel]?, Error?) -> ()) {
        var summaries: [MessageSummaryModel]? = []
        for _ in 0..<30 { summaries?.append(TestMessageSummaryModel().toModel()) }
        summaries?.sort(by: { $0.time > $1.time })
        delay { completion(summaries, nil) }
    }

    func getBlogSummaries(completion: @escaping ([BlogSummaryModel]?, Error?) -> ()) {
        var summaries: [BlogSummaryModel]? = []
        for _ in 0..<5 { summaries?.append(TestBlogSummaryModel().toModel()) }
        delay { completion(summaries, nil) }
    }
    
}
