//
//  TestService+House.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

extension TestService: HouseService {
    
    func getHouseSuggestions(userId: Int, completion: @escaping ([HouseSuggestionModel]?, Error?) -> ()) {
        var summaries: [HouseSuggestionModel]? = []
        for _ in 0..<20 { summaries?.append(TestHouseSuggestionModel().toModel()) }
        delay { completion(summaries, nil) }
    }

    func getHouseSaved(userId: Int, completion: @escaping ([HouseSavedModel]?, Error?) -> ()) {
        var summaries: [HouseSavedModel]? = []
        for _ in 0..<4 { summaries?.append(TestHouseSavedModel().toModel()) }
        delay { completion(summaries, nil) }
    }

}
