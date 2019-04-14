//
//  MessageTypeButton.swift
//  UniSpace
//
//  Created by KiKan Ng on 16/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

enum MessageGroupType: Int, Codable, CaseIterable {
    case Owner = 0
    case Team
    case Trade
    case Request
    case Admin

    var text: String {
        let role = DataStore.shared.user?.userType ?? .Tenant
        switch self {
        case .Owner: return role == .Tenant ? "Owner" : "Tenant"
        case .Team: return "Team"
        case .Trade: return "Trade"
        case .Request: return "Request"
        case .Admin: return "Admin"
        }
    }

    var color: UIColor {
        switch self {
        case .Owner: return UIColor(r: 238, g: 200, b: 87)
        case .Team: return UIColor(r: 75, g: 177, b: 157)
        case .Trade: return UIColor(r: 224, g: 122, b: 87)
        case .Request: return UIColor(r: 65, g: 146, b: 191)
        case .Admin: return .darkGray
        }
    }
}

enum HouseStatus: Int, Codable, CaseIterable {
    case Hide = 1
    case Reveal
    case Archive
    case Rent

    init?(text: String?) {
        guard let text = text else { return nil }
        switch text {
        case HouseStatus.Hide.text: self = .Hide
        case HouseStatus.Reveal.text: self = .Reveal
        case HouseStatus.Archive.text: self = .Archive
        case HouseStatus.Rent.text: self = .Rent
        default: return nil
        }
    }

    var text: String {
        switch self {
        case .Hide: return "Hide"
        case .Reveal: return "Reveal"
        case .Archive: return "Archive"
        case .Rent: return "Rent"
        }
    }

    var color: UIColor {
        switch self {
        case .Hide: return UIColor(r: 238, g: 200, b: 87)
        case .Reveal: return UIColor(r: 75, g: 177, b: 157)
        case .Archive: return UIColor(r: 224, g: 122, b: 87)
        case .Rent: return UIColor(r: 65, g: 146, b: 191)
        }
    }
}

class MessageTypeButton: UIButton {

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(isNumber: Bool) {
        super.init(frame: CGRect.zero)
        let width: CGFloat = isNumber ? 20 : 60
        setup(width: width)
    }

    func setType(title: String, color: UIColor) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
    }

    private func setup(width: CGFloat) {
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }

}
