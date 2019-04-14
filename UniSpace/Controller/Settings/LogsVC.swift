//
//  LogsVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 14/4/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class LogsVC: MasterFormPopupVC {

    private var logs: [URL]?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Logs"
        getLogs()
        createForm()
    }

    private func createForm() {
        guard let logs = logs else { return }

        form +++ Section("")
        for log in logs {
            form.last! <<< LabelRow() {
                $0.title = log.lastPathComponent
                }
                .onCellSelection { (cell, row) in
                    let vc = LogDetailVC()
                    vc.logURL = log
                    self.navigationController?.pushViewController(vc, animated: true)
                }
        }
    }

    private func getLogs() {
        var logs: [URL] = []
        let homeDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let enumerator = FileManager.default.enumerator(at: homeDir, includingPropertiesForKeys: nil)
        while let element = enumerator?.nextObject() as? URL {
            let filename = element.lastPathComponent
            if !filename.hasSuffix(".log") { continue }
            logs.append(element)
        }
        logs.sort(by: { $0.lastPathComponent < $1.lastPathComponent })
        self.logs = logs
    }
}
