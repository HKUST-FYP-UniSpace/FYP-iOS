//
//  RegisterDetailVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

// 170
import UIKit

class RegisterDetailVC: MasterLoginVC {
    
    lazy private var usernameTextField = LoginTextField(text: "Username")
    lazy private var nameTextField = LoginTextField(text: "Name")
    lazy private var emailTextField = LoginTextField(text: "Email")
    lazy private var passwordTextField = LoginTextField(text: "Password")
    lazy private var confirmPasswordTextField = LoginTextField(text: "Confirm password")
    lazy private var nextButton = LoginButton(buttonText: "Next")

    lazy private var titleLabel = LoginLabel(labelText: "Register", isTitle: true)
    lazy private var detailLabel = LoginLabel(labelText: "Input your personal info", isTitle: false)
    
    private var isTenant: Bool = false
    
    convenience init(isTenant: Bool) {
        self.init()
        self.isTenant = isTenant
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        setupTheme(theme: Color.theme, background: Color.Login.background)
    }
    
    private func setupUI() {
        emailTextField.placeholder = isTenant ? "University email" : "Email"
        setupDetailLabel()
        setupTitleLabel()
        setupUsernameTextField()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupNextButton()
    }
    
    @objc func handleNext() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        let type: UserType = isTenant ? .Tenant : .Owner
        guard let username = usernameTextField.text,
            let name = nameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text
            else {
                showAlert(title: "Please input all fields")
                return
        }
        
        guard email.isEmail() else {
            showAlert(title: "The email is not legal")
            return
        }

        guard password == confirmPassword else {
            showAlert(title: "Password and confirm password are not the same")
            return
        }
        
        DataStore.shared.register(userType: type, username: username, name: name, email: email, password: password) { (user, error) in
            guard user != nil else {
                self.showAlert(title: "Registration failed")
                return
            }
            
            let vc = VerificationVC()
            vc.username = username
            vc.password = password
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


extension RegisterDetailVC {
    
    private func setupDetailLabel() {
        view.addSubview(detailLabel)
        detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -170).isActive = true
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: detailLabel.topAnchor, constant: -2).isActive = true
    }
    
    private func setupUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.setBottomBorder()
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 50).isActive = true
        usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideSuggestBound).isActive = true
        usernameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideSuggestBound).isActive = true
    }
    
    private func setupNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.setBottomBorder()
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideSuggestBound).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideSuggestBound).isActive = true
    }
    
    private func setupEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.setBottomBorder()
        emailTextField.keyboardType = .emailAddress
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideSuggestBound).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideSuggestBound).isActive = true
    }
    
    private func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.setBottomBorder()
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideSuggestBound).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideSuggestBound).isActive = true
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setupConfirmPasswordTextField() {
        view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.setBottomBorder()
        confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        confirmPasswordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideSuggestBound).isActive = true
        confirmPasswordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideSuggestBound).isActive = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    private func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 40).isActive = true
        nextButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    }
    
}
