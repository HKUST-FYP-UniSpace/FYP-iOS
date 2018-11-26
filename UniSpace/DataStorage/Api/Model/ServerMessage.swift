//
//  ServerMessage.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//


class ServerMessage: Decodable {
    
    var message: String = ""
    var code: Int = 0
    var resource: String = ""
    
    init() {
        
    }
}


// Example response

//"message": "This product category does not exist",
//"code": -2000,
//"resource": "edit()"
