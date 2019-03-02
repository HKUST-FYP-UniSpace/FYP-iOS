//
//  TradeSendMessageVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 28/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class TradeSendMessageVC: MasterFormPopupVC {

    private var tradeItemId: Int
    private var message: String?

    init(tradeItemId: Int) {
        self.tradeItemId = tradeItemId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Send Message"
        createForm()
    }

    private func createForm() {
        form +++ Section("Message")
            <<< getTextAreaRow(id: "message", placeholder: "Enter your message here", defaultValue: nil)

        form +++ Section("")
            <<< getButtonRow(id: nil, title: "Send", callback: {
                self.updateModel()
                
                guard let message = self.message else {
                    self.showAlert(title: "Please finish the form")
                    return
                }

                DataStore.shared.contactOwner(itemId: self.tradeItemId, message: message, completion: { (msg, error) in
                    guard !self.sendFailed(msg, error: error) else { return }
                    self.dismiss(animated: true, completion: nil)
                })
            })
    }

    private func updateModel() {
        if let row = form.rowBy(tag: "message") as? TextAreaRow { self.message = row.value }

    }

}
