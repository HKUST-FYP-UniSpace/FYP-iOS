//
//  CreateMessageGroupVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 28/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka
import MessageKit

class CreateMessageGroupVC: MasterFormPopupVC {

    private var messageGroupType: MessageGroupType
    private var tradeItemId: Int?
    private var teamId: Int?
    private var message: String?

    init(_ messageGroupType: MessageGroupType, teamId: Int? = nil, tradeItemId: Int? = nil) {
        self.messageGroupType = messageGroupType
        self.teamId = teamId
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
                self.sendMessage()
            })
    }

    private func sendMessage() {
        guard let message = self.message else {
            self.showAlert(title: "Please finish the form")
            return
        }

        let sender = Sender(id: "", displayName: "")
        let mockMessage = MockMessage(text: message, sender: sender, messageId: "", date: Date())
        DataStore.shared.createNewMessageGroup(type: messageGroupType, message: mockMessage, teamId: teamId, itemId: tradeItemId, completion: completion)
    }

    private func completion(msg: String?, error: Error?) {
        guard !self.sendFailed(msg, error: error) else { return }
        self.dismiss(animated: true, completion: nil)
    }

    private func updateModel() {
        var message: String? = nil
        if let row = form.rowBy(tag: "message") as? TextAreaRow { message = row.value }
        guard let updateMessage = message, !updateMessage.isEmpty else {
            self.message = nil
            return
        }
        self.message = updateMessage
    }

}
