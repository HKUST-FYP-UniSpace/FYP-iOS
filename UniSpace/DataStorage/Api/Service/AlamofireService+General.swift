//
//  AlamofireGeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire
import MessageKit

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

        easyUpload(
            at: .editUserProfile,
            dataFormation: { (multipartFormData) in
                guard let imageData = image.jpegData(compressionQuality: 0.1) else {
                    completion?(nil, ServerError.ImageFormatError(format: "jpeg"))
                    return
                }
                multipartFormData.append(imageData, withName: "photoURL", fileName: "photoURL.jpeg", mimeType: "image/jpeg")
                for (key, value) in params {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
        }) { (res: DataResponse<Any>) in
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

    func getMessageDetails(messageId: Int, allowedUsers: [UserModel], completion: @escaping ([MockMessage]?, Error?) -> Void) {
        get(at: .getMessageDetails(messageId: messageId)).responseJSON { (res: DataResponse<Any>) in
            var result: [MessageModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([MessageModel].self, from: data) }
            guard let originalResult = result else {
                completion(nil, res.result.error)
                return
            }

            let messages = originalResult.map({ m -> MockMessage in
                let dummyUser = Sender(id: DataStore.shared.randomString(length: 8), displayName: "Unknown Unknown")
                let user = allowedUsers.first(where: { $0.id == m.senderId })?.toSender() ?? dummyUser
                let date = Date(timeIntervalSince1970: m.time)
                return MockMessage(text: m.message, sender: user, messageId: "\(m.id)", date: date)
            })
            completion(messages, res.result.error)
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
        get(at: .getCalendarSummaries(year: year, month: month)).responseJSON { (res: DataResponse<Any>) in
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
