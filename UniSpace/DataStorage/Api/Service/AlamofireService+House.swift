//
//  AlamofireService+House.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Alamofire

extension AlamofireService: HouseService {

    func getHouseSuggestions(userId: Int, completion: @escaping ([HouseSuggestionModel]?, Error?) -> Void) {
        completion(nil, nil)
    }

    func getHouseSaved(userId: Int, completion: @escaping ([HouseSavedModel]?, Error?) -> Void) {
        completion(nil, nil)
    }

}
