//
//  Constant.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

struct Spacing {
    static let narrow: CGFloat = 5
    static let normal: CGFloat = 10
    static let wide: CGFloat = 20
}

class Constants {

    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

    static let cardWidth_L: CGFloat = 900
    static let cardWidth_M: CGFloat = 400
    static let cardWidth_S: CGFloat = 200

    static let host = "http://pentagon.connectie-t.com:8080/api-mobile/v1"

    static func dummyPhotoURL(_ width: CGFloat, ratio: CGFloat = 0.75) -> String {
        return "https://picsum.photos/id/\(Int.random(in: 0...1084))/" + Int(width).description + "/" + Int(width * ratio).description
    }

}
