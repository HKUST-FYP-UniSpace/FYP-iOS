//
//  TestGeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: GeneralService {
    
    func getUserProfile(userId: Int, completion: @escaping (UserProfileModel?, Error?) -> Void) {
        completion(nil, nil)
    }

    func getMessageSummaries(userId: Int, completion: @escaping ([MessageSummaryModel]?, Error?) -> Void) {
        var summaries: [MessageSummaryModel]? = []
        for _ in 0..<30 { summaries?.append(TestMessageSummaryModel().toModel()) }
        summaries?.sort(by: { $0.time > $1.time })
        delay { completion(summaries, nil) }
    }

    func getNotificationSummaries(userId: Int, completion: @escaping ([NotificationSummaryModel]?, Error?) -> Void) {
        var summaries: [NotificationSummaryModel]? = []
        summaries?.append(TestNotificationSummaryModel(title: "Derek K. responds to your team request", subTitle: "Welcome buddy!").toModel())
        summaries?.append(TestNotificationSummaryModel(title: "Jessi J. replied to your comment", subTitle: "Looking good man!!").toModel())
        summaries?.append(TestNotificationSummaryModel(title: "Derek K. is interested in your apartment", subTitle: "").toModel())
        summaries?.append(TestNotificationSummaryModel(title: "Today is the contract sign day", subTitle: "Starbucks, BOC HQ, Central").toModel())
        summaries?.sort(by: { $0.time > $1.time })
        delay { completion(summaries, nil) }
    }

    func getBlogSummaries(completion: @escaping ([BlogSummaryModel]?, Error?) -> Void) {
        var summaries: [BlogSummaryModel]? = []
        for _ in 0..<5 { summaries?.append(TestBlogSummaryModel().toModel()) }
        delay { completion(summaries, nil) }
    }
    
}
