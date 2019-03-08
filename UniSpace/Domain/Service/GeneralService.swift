//
//  GeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

protocol GeneralService: class {

    func getMyUserDetail(completion: @escaping (_ user: UserModel?, _ error: Error?) -> Void)
    func getUserProfile(userId: Int, completion: @escaping (_ user: UserProfileModel?, _ error: Error?) -> Void)
    func getMessageSummaries(userId: Int, completion: @escaping (_ summaries: [MessageSummaryModel]?, _ error: Error?) -> Void)
    func getNotificationSummaries(userId: Int, completion: @escaping (_ summaries: [NotificationSummaryModel]?, _ error: Error?) -> Void)
    func getBlogSummaries(completion: @escaping (_ summaries: [BlogSummaryModel]?, _ error: Error?) -> Void)
    func getBlogDetail(blogId: Int, completion: @escaping (_ blog: BlogSummaryModel?, _ error: Error?) -> Void)

}
