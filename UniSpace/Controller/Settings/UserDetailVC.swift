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
    private var editedUser: UserModel?
    private var image: UIImage?

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
        updateModel()
        guard let editedUser = editedUser, let image = image else {
            self.showAlert(title: "Please input all cells")
            return
        }
        DataStore.shared.editUserProfile(userProfile: editedUser, image: image) { (msg, error) in
            guard !self.sendFailed(msg, error: error) else { return }
            self.dismiss(animated: true, completion: nil)
        }        
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
            <<< getLabelRow(id: nil, title: "User Type", displayValue: user?.userType.text)
            <<< getLabelRow(id: nil, title: "Username", displayValue: user?.username)
            <<< getLabelRow(id: nil, title: "Email", displayValue: user?.email)

        form +++ Section("Personal Information")
            <<< getLabelRow(id: nil, title: "Name", displayValue: user?.name)
            <<< getTextAreaRow(id: nil, placeholder: "self intro", defaultValue: user?.selfIntro, disable: true)
            <<< getLabelRow(id: nil, title: "Contact", displayValue: user?.contact)
            <<< getLabelRow(id: nil, title: "Gender", displayValue: user?.gender.description)
    }

    private func editForm() {
        form +++ Section("")
            <<< getImageRow(url: user?.photoURL, canChange: true)
            <<< getLabelRow(id: nil, title: "User Type", displayValue: user?.userType.text)
            <<< getLabelRow(id: nil, title: "Username", displayValue: user?.username)
            <<< getLabelRow(id: nil, title: "Email", displayValue: user?.email)

        form +++ Section("Personal Information")
            <<< getTextRow(id: "name", title: "Name", defaultValue: user?.name)
            <<< getTextAreaRow(id: "selfIntro", placeholder: "self intro", defaultValue: user?.selfIntro, disable: false)
            <<< getTextRow(id: "contact", title: "Contact", defaultValue: user?.contact)
            <<< getSingleSelectorRow(id: "gender", title: "Gender", defaultValue: user?.gender.description, selectorTitle: nil, options: Gender.allCases.map { $0.description })
    }

    private func updateModel() {
        image = nil
        for row in form.allRows {
            guard let imageRow = row as? ChangeImageRow, let image = imageRow.cell.getImage() else { continue }
            self.image = image
        }

        var name: String? = nil
        var selfIntro: String? = nil
        var contact: String? = nil
        var gender: Gender? = nil
        if let row = form.rowBy(tag: "gender") as? ActionSheetRow<String> {
            if let value = row.value {
                if value == Gender.Male.description {
                    gender = .Male
                } else if value == Gender.Female.description {
                    gender = .Female
                }
            }
        }
        if let row = form.rowBy(tag: "name") as? TextRow { name = row.value }
        if let row = form.rowBy(tag: "selfIntro") as? TextAreaRow { selfIntro = row.value }
        if let row = form.rowBy(tag: "contact") as? TextRow { contact = row.value }

        guard let updateName = name,
            let updateSelfIntro = selfIntro,
            let updateContact = contact,
            let updateGender = gender else {
                self.editedUser = nil
                return
        }
        let model = UserModel()
        model.name = updateName
        model.selfIntro = updateSelfIntro
        model.contact = updateContact
        model.gender = updateGender
        self.editedUser = model
    }

}
