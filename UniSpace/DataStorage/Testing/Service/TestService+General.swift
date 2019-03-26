//
//  TestGeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

extension TestService: GeneralService {
    
    func getUserProfile(userId: Int, completion: @escaping (UserModel?, Error?) -> Void) {
        delay { completion(DataStore.shared.user, nil) }
    }

    func editUserProfile(userId: Int, userProfile: UserModel, image: UIImage, completion: SendRequestResult?) {
        DataStore.shared.user?.name = userProfile.name
        DataStore.shared.user?.selfIntro = userProfile.selfIntro
        DataStore.shared.user?.contact = userProfile.contact
        DataStore.shared.user?.gender = userProfile.gender
        delay { completion?(nil, nil) }
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
