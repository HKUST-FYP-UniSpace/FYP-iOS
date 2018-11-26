//
//  LoginVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class LoginVC: LoginMasterVC {
    
    lazy private var iconImage = UIImageView(image: UIImage(named: "Fake_icon"))
    lazy private var titleLabel = LoginLabel(labelText: "Welcome to UniSpace", isTitle: true)
    lazy private var detailLabel = LoginLabel(labelText: "Find roomies that fit you the most", isTitle: false)
    lazy private var usernameTextField = LoginTextField(text: "Username")
    lazy private var passwordTextField = LoginTextField(text: "Password")
    lazy private var loginButton = LoginButton(buttonText: "Login")
    lazy private var registerButton = LoginButton(buttonText: "Register")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        setupTheme(theme: Color.theme, background: Color.Login.background)
    }
    
    private func setupUI() {
        setupDetailLabel()
        setupTitleLabel()
        setupIconImage()
        setupUsernameTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupRegisterButton()
    }

    @objc func handleLogin() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            showAlert(title: "Please input your username and password")
            return
        }
        login(username: username, password: password, completion: loginCompletion)
    }
    
    @objc func handleRegister() {
        navigationController?.pushViewController(RegisterLandingVC(), animated: true)
    }

}


extension LoginVC {
    
    private func setupDetailLabel() {
        view.addSubview(detailLabel)
        detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        detailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideMaxBound).isActive = true
        detailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideMaxBound).isActive = true
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: detailLabel.topAnchor, constant: -2).isActive = true
    }
    
    private func setupIconImage() {
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconImage)
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -40).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 75).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    private func setupUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.setBottomBorder()
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 40).isActive = true
        usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideSuggestBound).isActive = true
        usernameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideSuggestBound).isActive = true
    }
    
    private func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.setBottomBorder()
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideSuggestBound).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideSuggestBound).isActive = true
        passwordTextField.isSecureTextEntry = true
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 80).isActive = true
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    private func setupRegisterButton() {
        view.addSubview(registerButton)
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)

    }
    
}
