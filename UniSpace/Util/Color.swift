//
//  Color.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

fileprivate struct ColorConstant {
    static let primary = UIColor(r: 25, g: 133, b: 132)
    static let titleBarGrey = UIColor(r: 240, g: 240, b: 240)
}

struct Color {
    static let theme = ColorConstant.primary
    
    struct Button {
        static let text = UIColor.white
        static let background = ColorConstant.primary
    }
    
    struct InverseButton {
        static let text = ColorConstant.primary
        static let background = ColorConstant.titleBarGrey
    }
    
    struct Login {
        static let title = UIColor.init(r: 74, g: 74, b: 74)
        static let detail = UIColor.init(r: 155, g: 155, b: 155)
        static let back = ColorConstant.primary
        static let background = UIColor.white
        static let inverseTitle = UIColor.white
        static let inverseDetail = UIColor.init(r: 216, g: 216, b: 216)
        static let inverseBack = UIColor.init(r: 216, g: 216, b: 216)
        static let inverseBackground = ColorConstant.primary
        static let optionBackground = ColorConstant.titleBarGrey
    }
    
}

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: a
        )
    }
    
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            r: (hex >> 16) & 0xFF,
            g: (hex >> 8) & 0xFF,
            b: hex & 0xFF,
            a: a
        )
    }
    
    // Usage: navigationBar.shadowImage = Color.applicationTheme.addBound()
    // To add a line between navigationBar and tableview
    func addBound() -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 2.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        self.setFill()
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
