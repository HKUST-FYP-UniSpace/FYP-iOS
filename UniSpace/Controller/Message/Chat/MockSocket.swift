//
//  MockSocket.swift
//  UniSpace
//
//  Created by KiKan Ng on 7/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import MessageKit

final class MockSocket {

    static var shared = MockSocket()

    private var timer: Timer?

    private var queuedMessages: [MockMessage]?

    private var onNewMessageCode: (([MockMessage]) -> Void)?

    private var onTypingStatusCode: (() -> Void)?

    private var messageId: Int?

    private var connectedUsers: [UserModel] = []

    private init() {}

    @discardableResult
    func connect(messageId: Int, with senders: [UserModel]) -> Self {
        disconnect()
        self.messageId = messageId
        connectedUsers = senders
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        return self
    }

    @discardableResult
    func disconnect() -> Self {
        timer?.invalidate()
        timer = nil
        onTypingStatusCode = nil
        onNewMessageCode = nil
        queuedMessages = nil
        return self
    }

    @discardableResult
    func onNewMessages(code: @escaping ([MockMessage]) -> Void) -> Self {
        onNewMessageCode = code
        return self
    }

    @discardableResult
    func onTypingStatus(code: @escaping () -> Void) -> Self {
        onTypingStatusCode = code
        return self
    }

    @objc
    private func handleTimer() {
        if let message = queuedMessages {
            onNewMessageCode?(message)
            queuedMessages = nil
        } else {
            guard let messageId = messageId else { return }
            DataStore.shared.getMessageDetails(messageId: messageId, allowedUsers: connectedUsers) { (messages, error) in
                self.queuedMessages = messages
            }
            onTypingStatusCode?()
        }
    }

    func cleanQueuedMessages() {
        queuedMessages = nil
    }

}
