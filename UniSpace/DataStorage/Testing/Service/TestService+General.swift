//
//  TestGeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: GeneralService {

    func getMyUserDetail(completion: @escaping (UserModel?, Error?) -> Void) {
        delay { completion(DataStore.shared.user, nil) }
    }
    
    func getUserProfile(userId: Int, completion: @escaping (UserProfileModel?, Error?) -> Void) {
        let user = TestUserProfileModel(username: "John Doe").toModel()
        delay { completion(user, nil) }
    }

    func getMessageSummaries(userId: Int, completion: @escaping ([MessageSummaryModel]?, Error?) -> Void) {
        var summaries: [MessageSummaryModel]? = []
        for _ in 0..<Int.random(in: (5..<30)) { summaries?.append(TestMessageSummaryModel().toModel()) }
        summaries?.sort(by: { $0.time > $1.time })
        delay { completion(summaries, nil) }
    }

    func getNotificationSummaries(userId: Int, completion: @escaping ([NotificationSummaryModel]?, Error?) -> Void) {
        var summaries: [NotificationSummaryModel]? = []
        summaries?.append(TestNotificationSummaryModel(title: "Derek K. responds to your team request", subtitle: "Welcome buddy!").toModel())
        summaries?.append(TestNotificationSummaryModel(title: "Jessi J. replied to your comment", subtitle: "Looking good man!!").toModel())
        summaries?.append(TestNotificationSummaryModel(title: "Derek K. is interested in your apartment", subtitle: "").toModel())
        summaries?.append(TestNotificationSummaryModel(title: "Today is the contract sign day", subtitle: "Starbucks, BOC HQ, Central").toModel())
        summaries?.sort(by: { $0.time > $1.time })
        delay { completion(summaries, nil) }
    }

    func getBlogSummaries(completion: @escaping ([BlogSummaryModel]?, Error?) -> Void) {
        var summaries: [BlogSummaryModel]? = []
        for _ in 0..<Int.random(in: (1..<5)) { summaries?.append(TestBlogSummaryModel().toModel()) }
        summaries?.sort(by: { $0.time > $1.time })
        delay { completion(summaries, nil) }
    }

    func getBlogDetail(blogId: Int, completion: @escaping (BlogSummaryModel?, Error?) -> Void) {
        let blog = TestBlogSummaryModel().toModel()
        delay { completion(blog, nil) }
    }
}
