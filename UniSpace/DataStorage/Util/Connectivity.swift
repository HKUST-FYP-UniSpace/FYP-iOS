//
//  Connectivity.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Alamofire

class Connectivity {
    
    static let shared = Connectivity()
    
    let reachabilityManager = NetworkReachabilityManager()
    
    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    static var isWifi: Bool {
        return NetworkReachabilityManager()?.isReachableOnEthernetOrWiFi ?? false
    }
    
    static var isCellular: Bool {
        return NetworkReachabilityManager()?.isReachableOnWWAN ?? false
    }
    
    
    func startNetworkReachabilityObserver() {
        
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                log.info("Connectivity", context: "The network is not reachable")
                
            case .unknown:
                log.info("Connectivity", context: "It is unknown whether the network is reachable")
                
            case .reachable(.ethernetOrWiFi):
                log.info("Connectivity", context: "The network is reachable over the WiFi connection")
                
            case .reachable(.wwan):
                log.info("Connectivity", context: "The network is reachable over the WWAN connection")
            }
        }
        
        // start listening
        reachabilityManager?.startListening()
    }
}
