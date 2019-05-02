//
//  UserModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation
import MessageKit

class UserModel: Decodable, Equatable, User {

    var id: Int = 0
    var username: String = ""
    var preference: PreferenceModel = PreferenceModel()
    var photoURL: String = ""
    var contact: String = ""
    var selfIntro: String = ""
    var name: String = ""
    var email: String = ""
    var gender: Gender? = nil
    var userType: UserType = .Tenant
    var isActive: Bool = false
    var createTime: Double = 0
    var verified: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case preference
        case photoURL
        case contact
        case selfIntro
        case name
        case email
        case gender
        case role = "userType"
        case isActive
        case createTime
        case verified
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        decode(container, &id, type: Int.self, forKey: .id)
        decode(container, &username, type: String.self, forKey: .username)
        decode(container, &preference, type: PreferenceModel.self, forKey: .preference)
        decode(container, &photoURL, type: String.self, forKey: .photoURL)
        decode(container, &contact, type: String.self, forKey: .contact)
        decode(container, &selfIntro, type: String.self, forKey: .selfIntro)
        decode(container, &name, type: String.self, forKey: .name)
        decode(container, &email, type: String.self, forKey: .email)
        decode(container, &gender, type: Gender?.self, forKey: .gender)
        decode(container, &userType, type: UserType.self, forKey: .role)
        var isActiveInt: Int = 0
        decode(container, &isActiveInt, type: Int.self, forKey: .isActive)
        isActive = isActiveInt == 1
        decode(container, &createTime, type: Double.self, forKey: .createTime)
        var isVerifiedInt: Int = 0
        decode(container, &isVerifiedInt, type: Int.self, forKey: .verified)
        verified = isVerifiedInt == 1
    }

    private func decode<T>(_ container: KeyedDecodingContainer<CodingKeys>, _ variable: inout T, type: T.Type, forKey key: CodingKeys) where T: Decodable {
        if let _variable = try? container.decode(type, forKey: key) {
            variable = _variable
        }
    }

    init() {}

    static func ==(lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }

    func getNameAndUsername() -> String {
        if !name.isEmpty, !username.isEmpty {
            return "\(name) (\(username))"
        }
        return name.isEmpty ? username : name
    }

    func toSender() -> Sender {
        return Sender(id: "\(id)", displayName: name)
    }

}
