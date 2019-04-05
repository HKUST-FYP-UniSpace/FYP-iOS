//
//  GeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

protocol GeneralService: class {

    func getUserProfile(userId: Int, completion: @escaping (_ user: UserModel?, _ error: Error?) -> Void)
    func editUserProfile(userProfile: UserModel, image: UIImage, completion: SendRequestResult?)
    func getMessageSummaries(completion: @escaping (_ summaries: [MessageSummaryModel]?, _ error: Error?) -> Void)
    func getNotificationSummaries(completion: @escaping (_ summaries: [NotificationSummaryModel]?, _ error: Error?) -> Void)
    func getCalendarSummaries(year: Int, month: Int, completion: @escaping (_ summaries: [CalendarDataListModel]?, _ error: Error?) -> Void)
    func getBlogSummaries(completion: @escaping (_ summaries: [BlogSummaryModel]?, _ error: Error?) -> Void)
    func getBlogDetail(blogId: Int, completion: @escaping (_ blog: BlogSummaryModel?, _ error: Error?) -> Void)

}
