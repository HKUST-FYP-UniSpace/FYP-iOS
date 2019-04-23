//
//  TestMessageSummaryModel.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import Foundation

class TestMessageSummaryModel: MessageSummary {

    var id: Int = 0
    var title: String = ""
    var subtitle: String = ""
    var time: Double = 0
    var unreadMessagesCount: Int = 0
    var photoURL: String = ""
    var messageType: MessageGroupType = .Request
    var users: [UserModel] = []

    required init() {
        id = DataStore.shared.randomInt(length: 8)
        let type = MessageGroupType.allCases
        let randomNumber = Int.random(in: (0..<10))
        messageType = type.randomElement()!
        unreadMessagesCount = randomNumber % 2 == 0 ? 0 : randomNumber
        title = ["Derek K.", "Earth Mightiest Heros", "Jessi J.", "T'challa"].randomElement()!
        subtitle = Lorem.words().capitalizingFirstLetter()
        time = DateManager.shared.randomTime(30)
        photoURL = Constants.dummyPhotoURL(Constants.cardWidth_S, ratio: 1)

        let superman = TestUserModel(email: "", username: "man_of_steel", name: "Clark Kent", role: .Tenant, verified: true, hasPreference: true).toUserModel()
        superman.photoURL = "https://timedotcom.files.wordpress.com/2016/03/batman-vs-superman.jpg"
        let captainAmerica = TestUserModel(email: "", username: "star_spangled_man", name: "Steve Rogers", role: .Tenant, verified: true, hasPreference: true).toUserModel()
        captainAmerica.photoURL = "https://cdn1us.denofgeek.com/sites/denofgeekus/files/styles/main_wide/public/2016/08/steve-rogers.jpg?itok=PKuv3pPL"
        let theFlash = TestUserModel(email: "", username: "the_scarlet_speedster", name: "Barry Allen", role: .Tenant, verified: true, hasPreference: true).toUserModel()
        theFlash.photoURL = "https://fsmedia.imgix.net/23/0e/3d/2d/508b/4e92/878f/2402c15e47be/the-flash.jpeg?rect=0%2C54%2C800%2C400&auto=format%2Ccompress&dpr=2&w=650"

//        if let currentUser = DataStore.shared.user {
//            users.append(currentUser)
//        }
        var testUsers = [superman, captainAmerica, theFlash]
        users.append(testUsers.remove(at: Int.random(in: 0..<testUsers.count)))
        if messageType == .Team {
            users.append(contentsOf: testUsers)
        } else {
            title = users.first!.name
        }
    }

    func toModel() -> MessageSummaryModel {
        let model = MessageSummaryModel()
        model.id = id
        model.title = title
        model.subtitle = subtitle
        model.time = time
        model.unreadMessagesCount = unreadMessagesCount
        model.photoURL = photoURL
        model.messageType = messageType
        model.users = users
        return model
    }
}
