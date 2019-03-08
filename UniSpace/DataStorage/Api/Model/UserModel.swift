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
    var email: String = ""
    var familyName: String = ""
    var givenName: String = ""
    var gender: Gender = .Male
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
        case email
        case familyName
        case givenName
        case gender
        case role
        case isActive
        case createTime
        case verified
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        preference = try container.decode(PreferenceModel.self, forKey: .preference)
        photoURL = try container.decode(String.self, forKey: .photoURL)
        email = try container.decode(String.self, forKey: .email)
        familyName = try container.decode(String.self, forKey: .familyName)
        givenName = try container.decode(String.self, forKey: .givenName)
        let genderInt = try container.decode(Int.self, forKey: .gender)
        gender = Gender(rawValue: genderInt) ?? .Male
        let userTypeInt = try container.decode(Int.self, forKey: .role)
        userType = UserType(rawValue: userTypeInt) ?? .Tenant
        isActive = try container.decode(Bool.self, forKey: .isActive)
        createTime = try container.decode(Double.self, forKey: .createTime)
        verified = try container.decode(Bool.self, forKey: .verified)
    }

}
