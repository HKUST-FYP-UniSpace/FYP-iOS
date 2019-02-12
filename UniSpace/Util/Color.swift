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
    static let hightlightedPrimary = UIColor(r: 24, g: 167, b: 169)
    static let titleBarGray = UIColor(r: 240, g: 240, b: 246)
    static let hightlightedGray = UIColor(r: 143, g: 143, b: 147)
    static let transparentWhite = UIColor(white: 1, alpha: 0.8)
}

struct Color {
    static let theme = ColorConstant.primary
    static let white = ColorConstant.transparentWhite
    
    struct Button {
        static let text = UIColor.white
        static let background = ColorConstant.primary
        static let hightlighted = ColorConstant.hightlightedPrimary
    }
    
    struct InverseButton {
        static let text = ColorConstant.primary
        static let background = ColorConstant.titleBarGray
        static let hightlighted = ColorConstant.hightlightedGray
    }
    
    struct Option {
        static let background = ColorConstant.titleBarGray
        static let hightlighted = ColorConstant.hightlightedGray
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
    
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
}

func generateRandomData() -> [[UIColor]] {
    let numberOfRows = 20
    let numberOfItemsPerRow = 15
    
    return (0..<numberOfRows).map { _ in
        return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
    }
}
