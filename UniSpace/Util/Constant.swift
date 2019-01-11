//
//  Constant.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

class Constants {

    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

    static let host = "http://pentagon.connectie-t.com:8080/api-mobile/v1"

    static func dummyPhotoURL(_ width: CGFloat) -> String {
        return "https://unsplash.it/" + width.description + "/" + (width * 0.75).description + "/?random"
    }

}
