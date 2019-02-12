//
//  Bookmarkable.swift
//  UniSpace
//
//  Created by KiKan Ng on 13/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

@objc protocol Bookmarkable {
    var isBookmarked: Bool { get set }
    @objc func heartButton(_ sender: UIButton)
}

extension Bookmarkable where Self: UIViewController {
    func createBookmark(isBookmarked: Bool) -> UIBarButtonItem {
        let name = isBookmarked ? "Heart_filled" : "Heart"
        let heart = UIBarButtonItem(image: UIImage(named: name), style: .plain, target: self, action: #selector(heartButton))
        heart.tintColor = Color.theme
        return heart
    }
}
