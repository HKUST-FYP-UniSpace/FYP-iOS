//
//  ImageSettable.swift
//  UniSpace
//
//  Created by KiKan Ng on 14/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

protocol ImageSettable {
    func setImage(image: UIImage?)
}

protocol PhotoShowable {
    var photoURL: String { get set }
}
