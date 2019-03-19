//
//  Preference.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol Preference {

    var id: Int { get set }
    var gender: Gender? { get set }
    var petFree: Bool? { get set }
    var timeInHouse: String? { get set }
    var personalities: [String]? { get set }
    var interests: [String]? { get set }

}

enum Gender: Int, Codable, CaseIterable {
    case Male = 0
    case Female

    var text: String {
        switch self {
        case .Male: return "Boys only"
        case .Female: return "Girls only"
        }
    }

    var description: String {
        switch self {
        case .Male: return "Male"
        case .Female: return "Female"
        }
    }
}

class PreferenceOptions {

    static var gender: [String] {
        var gender: [String] = Gender.allCases.map { $0.text }
        gender.append("No preference")
        return gender
    }

    static let timeInHouse = ["Very Often", "Sometimes", "Rarely"]

    static let personalities = ["Adaptable", "Adventurous", "Affectionate", "Ambitious", "Amiable", "Compassionate", "Considerate", "Courageous", "Courteous", "Diligent", "Empathetic", "Exuberant", "Frank", "Generous", "Gregarious", "Impartial", "Intuitive", "Inventive", "Passionate", "Persistent", "Philosophical", "Practical", "Rational", "Reliable", "Resourceful", "Sensible", "Sincere", "Sympathetic", "Unassuming", "Witty"]
    
    static let interests = ["Music", "Sports", "Video Games", "Board Games", "Party Goer", "Light Drinker"]

}
