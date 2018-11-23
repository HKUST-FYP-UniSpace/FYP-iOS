//
//  ServerMessage.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import ObjectMapper

class ServerMessage: Mappable{
    var message: String?
    var code: Int?
    var resource: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.message <- map["message"]
        self.code <- map["code"]
        self.resource <- map["resource"]
    }
}


// Example response

//"message": "This product category does not exist",
//"code": -2000,
//"resource": "edit()"
