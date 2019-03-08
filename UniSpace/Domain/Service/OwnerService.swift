//
//  OwnerService.swift
//  UniSpace
//
//  Created by KiKan Ng on 8/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

protocol OwnerService: class {

    func getOwnerStatsSummary(userId: Int, completion: @escaping (_ summaries: [OwnerStatsSummaryModel]?, _ error: Error?) -> Void)

}
