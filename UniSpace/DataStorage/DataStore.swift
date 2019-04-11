//
//  DataStore.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

enum Service {
    case Alamofire
    case Local
}

class DataStore: NSObject {
    
    public static let shared: DataStore = DataStore()
    private var currentService: Service = .Local

    private override init() {
        super.init()
    }

    func changeService(_ service: Service) {
        self.currentService = service
    }
    
    func Service() -> AuthService & GeneralService & OwnerService & HouseService & TradeService {
        return currentService == .Local ? TestService.shared : AlamofireService.shared
    }
    
    var user: UserModel?
    
}

extension DataStore {

    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length - 1).map{ _ in letters.randomElement()! })
    }

    func randomInt(length: Int) -> Int {
        let letters = "0123456789"
        let string = String((0...length - 1).map{ _ in letters.randomElement()! })
        return Int(string)!
    }

}
