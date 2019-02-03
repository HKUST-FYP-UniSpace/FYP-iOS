//
//  HouseService.swift
//  UniSpace
//
//  Created by KiKan Ng on 2/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

protocol HouseService: class {

    func getHouseSuggestions(userId: Int, completion: @escaping (_ summaries: [HouseSuggestionModel]?, _ error: Error?) -> Void)
    func getHouseSaved(userId: Int, completion: @escaping (_ summaries: [HouseSavedModel]?, _ error: Error?) -> Void)
}
