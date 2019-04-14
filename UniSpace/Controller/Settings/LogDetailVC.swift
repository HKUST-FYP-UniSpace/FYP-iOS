//
//  LogDetailVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 14/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class LogDetailVC: MasterFormPopupVC {

    var logURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = logURL?.lastPathComponent
        createForm()
    }

    private func createForm() {
        guard let logURL = logURL else { return }
        var log = try? String(contentsOf: logURL, encoding: .utf8)
        log = log?.replacingOccurrences(of: "\n", with: "\n\n")

        form +++ Section("")
        <<< getTextAreaRow(id: nil, placeholder: nil, defaultValue: log, disable: true)
    }
}
