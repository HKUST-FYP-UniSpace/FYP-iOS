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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func login(username: String, password: String, completion: @escaping (UserModel?, Error?) -> ()) {
        log.verbose("VC", context: "Attempt to login")
        
        UserDefaultsManager.savePref("username", value: username)
        UserDefaultsManager.savePref("password", value: password)
        
        DataStore.shared.authorize { (user, error) in
            guard user != nil else {
                completion(user, error)
                return
            }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.redirecting(authorized: true)
        }
    }
    
    func showAlert(title: String?, msg: String? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func loginCompletion(user: UserModel?, error: Error?) {
        if user == nil {
            showAlert(title: "Wrong username or password")
        }
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
    
}

extension LoginMasterVC {
    
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
