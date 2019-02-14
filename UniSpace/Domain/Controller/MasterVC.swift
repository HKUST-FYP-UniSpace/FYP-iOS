//
//  MasterVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 1/12/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import UIKit

class MasterVC: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        setupTheme(theme: Color.theme, background: Color.white, withLine: true)
        loadData()
    }

    func loadData() {}
    
    func login(username: String, password: String, completion: @escaping (UserModel?, Error?) -> ()) {
        log.verbose("VC", context: "Attempt to login")
        
        DataStore.shared.savePref(.username, value: username)
        DataStore.shared.savePref(.password, value: password)
        
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

    func setupLargeTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = Color.white
        navigationController?.view.backgroundColor = Color.white
    }

    func sendFailed(_ message: String?, error: Error?) -> Bool {
        if message == nil && error == nil { return false }
        if let message = message { showAlert(title: message) }
        else if let error = error { showAlert(title: error.localizedDescription) }
        return true
    }

}

extension UIViewController {
    func setupTheme(theme: UIColor, background: UIColor, withLine: Bool) {
        view.backgroundColor = background
        UIApplication.shared.statusBarView?.backgroundColor = background

        guard let navigationController = navigationController else { return }
        let navigationBar = navigationController.navigationBar
        navigationBar.backgroundColor = background
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        if !withLine { navigationBar.shadowImage = UIImage() }
    }
}
