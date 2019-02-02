//
//  GeneralService.swift
//  UniSpace
//
//  Created by KiKan Ng on 23/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import Foundation

protocol GeneralService: class {
    
    func getUserProfile(userId: Int, completion: @escaping (_ user: UserProfileModel?, _ error: Error?) -> ())
    func getMessageSummaries(userId: Int, completion: @escaping (_ summaries: [MessageSummaryModel]?, _ error: Error?) -> ())
    func getBlogSummaries(completion: @escaping (_ summaries: [BlogSummaryModel]?, _ error: Error?) -> ())
}
