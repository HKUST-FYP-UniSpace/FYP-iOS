//
//  AlamofireGeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire

extension AlamofireService: GeneralService {
    
    func getUserProfile(userId: Int, completion: @escaping (UserModel?, Error?) -> Void) {
        get(at: .getUserProfile).responseJSON { (res: DataResponse<Any>) in
            var result: UserModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(UserModel.self, from: data) }
            completion(result, res.result.error)
        }
    }

    func editUserProfile(userProfile: UserModel, image: UIImage, completion: SendRequestResult?) {
        var params = Parameters()
        params["name"] = userProfile.name
        params["selfIntro"] = userProfile.selfIntro
        params["contact"] = userProfile.contact
        params["gender"] = userProfile.gender?.rawValue ?? Gender.Male.rawValue
        params["photoURL"] = image
        post(at: .getUserProfile, params: params).responseJSON { (res: DataResponse<Any>) in
            var result: UserModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(UserModel.self, from: data) }
            if let result = result { DataStore.shared.user = result }
            completion?(nil, res.result.error)
        }
    }

    func getMessageSummaries(completion: @escaping ([MessageSummaryModel]?, Error?) -> Void) {
        get(at: .getMessageSummaries).responseJSON { (res: DataResponse<Any>) in
            var result: [MessageSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([MessageSummaryModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getNotificationSummaries(completion: @escaping ([NotificationSummaryModel]?, Error?) -> Void) {
        get(at: .getNotificationSummaries).responseJSON { (res: DataResponse<Any>) in
            var result: [NotificationSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([NotificationSummaryModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getCalendarSummaries(year: Int, month: Int, completion: @escaping ([CalendarDataListModel]?, Error?) -> Void) {
        get(at: .getCalendarSummaries).responseJSON { (res: DataResponse<Any>) in
            var result: [CalendarDataListModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([CalendarDataListModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getBlogSummaries(completion: @escaping ([BlogSummaryModel]?, Error?) -> Void) {
        get(at: .getBlogSummaries).responseJSON { (res: DataResponse<Any>) in
            var result: [BlogSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([BlogSummaryModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getBlogDetail(blogId: Int, completion: @escaping (BlogSummaryModel?, Error?) -> Void) {
        get(at: .getBlogDetail(blogId: blogId)).responseJSON { (res: DataResponse<Any>) in
            var result: BlogSummaryModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(BlogSummaryModel.self, from: data) }
            completion(result, res.result.error)
        }
    }
    
}
