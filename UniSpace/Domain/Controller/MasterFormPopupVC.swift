//
//  MasterFormPopupVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 19/2/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class MasterFormPopupVC: FormViewController {

    var rootVC: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        rootVC = navigationController?.viewControllers.count == 1
        tableView.backgroundColor = .white

        let imageName = rootVC ? "Delete" : "Back"
        let cancelItem = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: #selector(cancelButton))
        cancelItem.tintColor = .darkGray
        navigationItem.leftBarButtonItem = cancelItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTheme(theme: Color.theme, background: Color.white, withLine: false)
        navigationItem.largeTitleDisplayMode = .never
        tableView.tableFooterView = UIView()
    }

    @objc func cancelButton(_ sender: UIButton) {
        if rootVC {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    override func inputAccessoryView(for row: BaseRow) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = UIColor.clear
            view.textLabel?.backgroundColor = UIColor.clear
            view.textLabel?.textColor = Color.theme
        }
    }

}
