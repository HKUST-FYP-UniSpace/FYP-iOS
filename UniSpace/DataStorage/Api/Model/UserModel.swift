//
//  UserModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

class UserModel: Decodable, User {

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
    
    init() {}

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
        case role
        case isActive
        case createTime
        case verified
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let id = try? container.decode(Int.self, forKey: .id) { self.id = id }
        if let username = try? container.decode(String.self, forKey: .username) { self.username = username }
        if let preference = try? container.decode(PreferenceModel.self, forKey: .preference) { self.preference = preference }
        if let photoURL = try? container.decode(String.self, forKey: .photoURL) { self.photoURL = photoURL }
        if let contact = try? container.decode(String.self, forKey: .contact) { self.contact = contact }
        if let selfIntro = try? container.decode(String.self, forKey: .selfIntro) { self.selfIntro = selfIntro }
        if let name = try? container.decode(String.self, forKey: .name) { self.name = name }
        if let email = try? container.decode(String.self, forKey: .email) { self.email = email }
        if let gender = try? container.decode(Gender.self, forKey: .gender) { self.gender = gender }
        if let userType = try? container.decode(UserType.self, forKey: .role) { self.userType = userType }
        if let isActive = try? container.decode(Bool.self, forKey: .isActive) { self.isActive = isActive }
        if let createTime = try? container.decode(Double.self, forKey: .createTime) { self.createTime = createTime }
        if let verified = try? container.decode(Bool.self, forKey: .verified) { self.verified = verified }

        dump(self)
    }

    func getNameAndUsername() -> String {
        if !name.isEmpty, !username.isEmpty {
            return "\(name) (\(username))"
        }
        return name.isEmpty ? username : name
    }

}
