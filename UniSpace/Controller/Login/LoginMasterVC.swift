//
//  LoginMasterVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class LoginMasterVC: UIViewController, UIGestureRecognizerDelegate {
    
    let sideMaxBound: CGFloat = 20
    let sideSuggestBound: CGFloat = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupGestureRecognizer()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func login(username: String, password: String) {
        log.verbose("VC", context: "Attempt to login")
        
        UserDefaultsManager.savePref("username", value: username)
        UserDefaultsManager.savePref("password", value: password)
        
        // check with server
        directing(isLoginPage: true, authorized: true)
    }
    
    private func directing(isLoginPage: Bool, authorized: Bool = false) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.directing(isLoginPage: true, authorized: true)
    }
    
    func setupTheme(theme: UIColor, background: UIColor) {
        view.backgroundColor = background
        UIApplication.shared.statusBarView?.backgroundColor = background
        setupBackButtom(color: theme)
        
        guard let navigationController = navigationController else { return }
        let navigationBar = navigationController.navigationBar
        navigationBar.backgroundColor = background
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    private func setupGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        swipe.direction = .up
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(swipe)
    }
    
    private func setupBackButtom(color: UIColor) {
        let backItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(back))
        backItem.tintColor = color
        backItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        backItem.customView?.widthAnchor.constraint(equalToConstant: 10).isActive = true
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
