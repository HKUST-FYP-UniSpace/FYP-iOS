//
//  TestService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

class TestService: NSObject {
    
    public static let shared: TestService = TestService()
    public static var canLogin: Bool = true

    func delay(_ t: Double = 0.5, completion: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + t) {
            completion()
        }
    }

}
