//
//  UserProfileModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Eureka

class UserProfileModel: Decodable, Equatable, UserProfile {
    
    var id: Int = 0
    var username: String = ""
    var preference: PreferenceModel = PreferenceModel()
    var photoURL: String = ""
    
    init() {}

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case preference
        case photoUrl
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
//        preference = try container.decode(PreferenceModel.self, forKey: .preference)
        photoURL = try container.decode(String.self, forKey: .photoUrl)
    }

    static func ==(lhs: UserProfileModel, rhs: UserProfileModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
