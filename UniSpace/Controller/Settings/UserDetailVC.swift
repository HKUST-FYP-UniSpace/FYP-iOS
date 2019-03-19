//
//  UserDetailVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 19/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class UserDetailVC: MasterFormPopupVC {

    var userId: Int?
    private var user: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Detail"
        if let currentUserId = DataStore.shared.user?.id, let userId = userId {
            if currentUserId == userId { addButton(isEdit: true) }
        }
        loadData()
    }

    @objc func editButton(_ sender: UIButton) {
        addButton(isEdit: false)
        form.removeAll()
        editForm()
        tableView.reloadData()
    }

    @objc func doneButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    private func addButton(isEdit: Bool) {
        let title = isEdit ? "Edit" : "Done"
        let style: UIBarButtonItem.Style = isEdit ? .plain : .done
        let action = isEdit ? #selector(editButton) : #selector(doneButton)
        let item = UIBarButtonItem(title: title, style: style, target: self, action: action)
        navigationItem.rightBarButtonItem = item
    }

    private func loadData() {
        guard let userId = userId else { return }
        DataStore.shared.getUserProfile(userId: userId) { (user, error) in
            self.user = user
            self.createForm()
            self.tableView.reloadData()
        }
    }

    private func createForm() {
        form +++ Section("")
            <<< getImageRow(url: user?.photoURL, canChange: false)
            <<< getLabelRow(id: nil, title: "Username", displayValue: user?.username)
            <<< getLabelRow(id: nil, title: "Name", displayValue: user?.name)
            <<< getTextAreaRow(id: nil, placeholder: "self intro", defaultValue: user?.selfIntro, disable: true)
            <<< getLabelRow(id: nil, title: "Contact", displayValue: user?.contact)
            <<< getLabelRow(id: nil, title: "Email", displayValue: user?.email)
            <<< getLabelRow(id: nil, title: "Gender", displayValue: user?.gender.description)
            <<< getLabelRow(id: nil, title: "User Type", displayValue: user?.userType.text)
    }

    private func editForm() {
        form +++ Section("")
            <<< getImageRow(url: user?.photoURL, canChange: true)
            <<< getTextRow(id: nil, title: "Username", defaultValue: user?.username)
            <<< getTextRow(id: nil, title: "Name", defaultValue: user?.name)
            <<< getTextAreaRow(id: nil, placeholder: "self intro", defaultValue: user?.selfIntro, disable: false)
            <<< getTextRow(id: nil, title: "Contact", defaultValue: user?.contact)
            <<< getTextRow(id: nil, title: "Email", defaultValue: user?.email)
            <<< getTextRow(id: nil, title: "Gender", defaultValue: user?.gender.description)
            <<< getTextRow(id: nil, title: "User Type", defaultValue: user?.userType.text)
    }

}
