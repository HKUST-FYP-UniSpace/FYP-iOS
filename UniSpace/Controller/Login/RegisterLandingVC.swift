//
//  RegisterLandingVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class RegisterLandingVC: LoginMasterVC {
    
    lazy private var titleLabel = LoginLabel(labelText: "Register", isTitle: true)
    lazy private var detailLabel = LoginLabel(labelText: "Choose your experience", isTitle: false)
    lazy private var tenant = RegisterChoiceButton(buttonText: UserType.Tenant.rawValue, buttonImage: UIImage(named: "Student_tenant"))
    lazy private var owner = RegisterChoiceButton(buttonText: UserType.Owner.rawValue, buttonImage: UIImage(named: "House_owner"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        setupTheme(theme: Color.theme, background: Color.Login.background)
    }
    
    private func setupUI() {
        setupTenant()
        setupOwner()
        setupDetailLabel()
        setupTitleLabel()
    }
    
    @objc func handleTenant() {
        navigationController?.pushViewController(RegisterDetailVC(isTenant: true), animated: true)
    }
    
    @objc func handleOwner() {
        navigationController?.pushViewController(RegisterDetailVC(isTenant: false), animated: true)
    }
    
}


extension RegisterLandingVC {
    
    private func setupTenant() {
        view.addSubview(tenant)
        tenant.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tenant.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        tenant.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideMaxBound).isActive = true
        tenant.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideMaxBound).isActive = true
        tenant.addTarget(self, action: #selector(handleTenant), for: .touchUpInside)
    }
    
    private func setupOwner() {
        view.addSubview(owner)
        owner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        owner.topAnchor.constraint(equalTo: tenant.bottomAnchor, constant: 40).isActive = true
        owner.leftAnchor.constraint(equalTo: view.leftAnchor, constant: sideMaxBound).isActive = true
        owner.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -sideMaxBound).isActive = true
        owner.addTarget(self, action: #selector(handleOwner), for: .touchUpInside)

    }
    
    private func setupDetailLabel() {
        view.addSubview(detailLabel)
        detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: tenant.topAnchor, constant: -50).isActive = true
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: detailLabel.topAnchor, constant: -2).isActive = true
    }
    
}
