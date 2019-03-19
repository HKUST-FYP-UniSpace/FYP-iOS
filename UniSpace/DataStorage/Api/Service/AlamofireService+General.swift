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
        get(at: .getUserProfile(userId: userId)).responseJSON { (res: DataResponse<Any>) in
            var result: UserModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(UserModel.self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getMessageSummaries(userId: Int, completion: @escaping ([MessageSummaryModel]?, Error?) -> Void) {
        get(at: .getMessageSummaries()).responseJSON { (res: DataResponse<Any>) in
            var result: [MessageSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([MessageSummaryModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getNotificationSummaries(userId: Int, completion: @escaping ([NotificationSummaryModel]?, Error?) -> Void) {
        get(at: .getNotificationSummaries()).responseJSON { (res: DataResponse<Any>) in
            var result: [NotificationSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([NotificationSummaryModel].self, from: data) }
            completion(result, res.result.error)
        }
    }

    func getBlogSummaries(completion: @escaping ([BlogSummaryModel]?, Error?) -> Void) {
        get(at: .getBlogSummaries()).responseJSON { (res: DataResponse<Any>) in
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
