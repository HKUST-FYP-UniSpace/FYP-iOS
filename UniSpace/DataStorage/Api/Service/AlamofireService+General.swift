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
        var params = Parameters()
        for time in RealmService.shared.getMessageGroups() {
            params["\(time.id)"] = time.timestamp
        }
        post(at: .getMessageSummaries, params: params).responseJSON { (res: DataResponse<Any>) in
            var result: [MessageSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([MessageSummaryModel].self, from: data) }
            result?.sort(by: { $0.time > $1.time })
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

            let messages = originalResult.sorted(by: { $0.id < $1.id }).map({ m -> MockMessage in
                let dummyUser = Sender(id: DataStore.shared.randomString(length: 8), displayName: "Unknown Unknown")
                let user = allowedUsers.first(where: { $0.id == m.senderId })?.toSender() ?? dummyUser
                let date = Date(timeIntervalSince1970: m.time)
                return MockMessage(text: m.message, sender: user, messageId: "\(m.id)", date: date)
            })
            completion(messages, res.result.error)
        }
    }

    func createNewMessageGroup(type: MessageGroupType, message: MockMessage, teamId: Int?, itemId: Int?, completion: SendRequestResult?) {
        let payload = getChatroomRoute(type, message, teamId, itemId)
        post(at: payload.0, params: payload.1).responseJSON { (res: DataResponse<Any>) in
            completion?(nil, res.result.error)
        }
    }

    func addNewMessage(messageId: Int, message: String, completion: SendRequestResult?) {
        var params = Parameters()
        params["message"] = message
        post(at: .sendMessage(messageId: messageId), params: params).responseJSON { (res: DataResponse<Any>) in
            completion?(nil, res.result.error)
//            self.sendRequestStandardHandling(res: res, followUpAction: nil, completion: completion)
        }
    }

    func getRequestStatus(messageId: Int, completion: @escaping (MessageRequestModel?, Error?) -> Void) {
        get(at: .getRequestStatus(messageId: messageId)).responseJSON { (res: DataResponse<Any>) in
            var result: MessageRequestModel? = nil
            if let data = res.data { result = try? JSONDecoder().decode(MessageRequestModel.self, from: data) }
            completion(result, res.result.error)
        }
    }

    func changeRequestStatus(messageId: Int, status: RequestStatus, completion: SendRequestResult?) {
        var params = Parameters()
        params["leaderId"] = DataStore.shared.user?.id
        params["acceptance"] = status == .Accepted ? true : false
        post(at: .changeRequestStatus(messageId: messageId), params: params).responseJSON { (res: DataResponse<Any>) in
            completion?(nil, res.result.error)
        }
    }

    func getNotificationSummaries(completion: @escaping ([NotificationSummaryModel]?, Error?) -> Void) {
        get(at: .getNotificationSummaries).responseJSON { (res: DataResponse<Any>) in
            var result: [NotificationSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([NotificationSummaryModel].self, from: data) }
            result?.sort(by: { $0.time > $1.time })
            completion(result, res.result.error)
        }
    }

    func getCalendarSummaries(year: Int, month: Int, completion: @escaping ([CalendarDataListModel]?, Error?) -> Void) {
        get(at: .getCalendarSummaries(year: year, month: month)).responseJSON { (res: DataResponse<Any>) in
            var result: [CalendarDataListModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([CalendarDataListModel].self, from: data) }
            result?.sort(by: { $0.date < $1.date })
            completion(result, res.result.error)
        }
    }

    func getBlogSummaries(completion: @escaping ([BlogSummaryModel]?, Error?) -> Void) {
        get(at: .getBlogSummaries).responseJSON { (res: DataResponse<Any>) in
            var result: [BlogSummaryModel]? = nil
            if let data = res.data { result = try? JSONDecoder().decode([BlogSummaryModel].self, from: data) }
            result?.sort(by: { $0.time > $1.time })
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

extension AlamofireService {
    private func getChatroomRoute(_ type: MessageGroupType, _ message: MockMessage, _ teamId: Int?, _ itemId: Int?) -> (ApiRoute, Parameters) {
        var params = Parameters()
        switch message.kind {
        case .text(let message):
            params["message"] = message
        default:
            fatalError()
        }

        switch type {
        case .Admin:
            return (.createAdminChatroom, params)

        case .Owner:
            params["teamId"] = teamId
            return (.createOwnerChatroom, params)

        case .Team:
            params["teamId"] = teamId
            return (.createTeamChatroom, params)

        case .Trade:
            params["tradeId"] = itemId
            return (.createTradeChatroom, params)

        case .Request:
            params["userId"] = DataStore.shared.user?.id
            return (.joinTeam(teamId: teamId ?? -1), params)
        }
    }
}
