//
//  UserProfile.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

protocol UserProfile: PhotoShowable {
    
    var id: Int { get set }
    var username: String { get set }
    var preference: PreferenceModel { get set }
    var photoURL: String { get set }
    
}
