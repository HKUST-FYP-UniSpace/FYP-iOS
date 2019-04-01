//
//  ImageSettable.swift
//  UniSpace
//
//  Created by KiKan Ng on 14/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

protocol ImageSettable {
    func setImage(_ image: UIImage?)
}

protocol PhotoShowable {
    func getFirstPhotoURL() -> String?
}

protocol HavePhoto: PhotoShowable {
    var photoURL: String { get set }
}

protocol HavePhotos: PhotoShowable {
    var photoURLs: [String] { get set }
}

extension HavePhoto {
    func getFirstPhotoURL() -> String? {
        return photoURL
    }
}

extension HavePhotos {
    func getFirstPhotoURL() -> String? {
        return photoURLs.first
    }
}

// TODO: Advance PhotoShowable
//protocol PhotoURL {
//    var S: String? { get set }
//    var M: String? { get set }
//    var L: String? { get set }
//}
//
//protocol PhotoShowable {
//    var photoURL: PhotoURL { get set }
//    func getURL(width: CGFloat) -> String?
//}
//
//extension PhotoShowable {
//    func getURL(width: CGFloat) -> String? {
//        let width_L: CGFloat = 900
//        let width_M: CGFloat = 400
//        let width_S: CGFloat = 200
//
//        switch width {
//        case 1...width_S: return photoURL.S
//        case width_S...width_M: return photoURL.M
//        case width_M...width_L: return photoURL.L
//        default: return nil
//        }
//    }
//}
