//
//  MasterVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/12/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class MasterVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = true
    }
    
    func login(username: String, password: String, completion: @escaping (UserModel?, Error?) -> ()) {
        log.verbose("VC", context: "Attempt to login")
        
        DataStore.shared.savePref("username", value: username)
        DataStore.shared.savePref("password", value: password)
        
        DataStore.shared.authorize { (user, error) in
            guard user != nil else {
                completion(user, error)
                return
            }
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.redirecting(authorized: true)
        }
    }
    
    func logout() {
        
    }
    
    func showAlert(title: String?, msg: String? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func loginCompletion(user: UserModel?, error: Error?) {
        if user == nil {
            showAlert(title: "Wrong username or password")
        }
    }
    
    func setupTheme(theme: UIColor, background: UIColor) {
        view.backgroundColor = background
        UIApplication.shared.statusBarView?.backgroundColor = background
        
        guard let navigationController = navigationController else { return }
        let navigationBar = navigationController.navigationBar
        navigationBar.backgroundColor = background
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }

}

extension MasterVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    private func setupGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipe.direction = .up
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(swipe)
    }

    @objc func dismissKeyboard() {
        navigationController?.navigationBar.endEditing(true)
        view.endEditing(true)
    }
}
