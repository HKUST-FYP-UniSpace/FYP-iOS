//
//  VerificationVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class VerificationVC: MasterLoginVC {
    
    var username: String = ""
    var password: String = ""
    
    lazy private var titleLabel = LoginLabel(labelText: "Verification", isTitle: true, inverseColor: true)
    lazy private var detailLabel = LoginLabel(labelText: "Please enter the 6 digits verification code sent to your email address", isTitle: false, inverseColor: true)
    lazy private var codeTextField = LoginTextField(text: "e.g. 000000", inverseColor: true)
    lazy private var verifyButton = LoginButton(buttonText: "Verify", inverseColor: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        setupTheme(theme: Color.Login.background, background: Color.theme)
    }
    
    private func setupUI() {
        setupDetailLabel()
        setupTitleLabel()
        setupCodeTextField()
        codeTextField.keyboardType = .numberPad
        setupVerifyButton()
    }
    
    @objc func handleVerify() {
        view.endEditing(true)
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        guard let id = DataStore.shared.user?.id, let code = codeTextField.text else {
            showAlert(title: "Please input the code")
            return
        }
        
        guard code.count == 6, code.isNumber() else {
            showAlert(title: "The code has to be a 6 digits number")
            return
        }
        
        DataStore.shared.verify(userId: id, code: code) { (user, error) in
            guard user != nil else {
                self.showAlert(title: "Wrong code")
                return
            }
            self.login(username: self.username, password: self.password, completion: self.loginCompletion)
        }
    }
    
}


extension VerificationVC {
    
    private func setupDetailLabel() {
        view.addSubview(detailLabel)
        detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -70).isActive = true
        detailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideMaxBound).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideMaxBound).isActive = true
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: detailLabel.topAnchor, constant: -2).isActive = true
    }
    
    private func setupCodeTextField() {
        view.addSubview(codeTextField)
        codeTextField.setBottomBorder(inverseColor: true)
        codeTextField.textAlignment = .center
        codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        codeTextField.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 80).isActive = true
        codeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideSuggestBound).isActive = true
        codeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideSuggestBound).isActive = true
    }
    
    private func setupVerifyButton() {
        view.addSubview(verifyButton)
        verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verifyButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 40).isActive = true
        verifyButton.addTarget(self, action: #selector(handleVerify), for: .touchUpInside)
    }
    
}
