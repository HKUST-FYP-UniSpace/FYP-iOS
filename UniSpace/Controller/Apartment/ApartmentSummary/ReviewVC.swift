//
//  ReviewVC.swift
//  UniSpace
//
//  Created by KiKan Ng on 20/3/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit
import Eureka

class ReviewVC: MasterFormPopupVC {

    var review: HouseReviewModel
    var isOwner: Bool
    private var comment: String?

    init(review: HouseReviewModel, isOwner: Bool) {
        self.review = review
        self.isOwner = isOwner
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Review"
        if isOwner {
            let item = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton))
            navigationItem.rightBarButtonItem = item
        }
        createForm()
    }


    @objc func doneButton(_ sender: UIButton) {
        updateModel()
        guard let comment = comment, !comment.isEmpty else {
            self.showAlert(title: "Comment should not be empty")
            return
        }
        DataStore.shared.replyReivew(reviewId: review.id, comment: comment) { (msg, error) in
            guard !self.sendFailed(msg, error: error) else { return }
        }
    }

    private func createForm() {
        form +++ Section("User Feedback")
            <<< getLabelRow(id: nil, title: "Username", displayValue: review.username)
            <<< getLabelRow(id: nil, title: "Date", displayValue: review.readableDate())
            <<< getLabelRow(id: nil, title: "Ratings", displayValue: "\(review.starRating)")
            <<< getTextAreaRow(id: nil, placeholder: "feedback title", defaultValue: review.title, disable: true)
            <<< getTextAreaRow(id: nil, placeholder: "feedback detail", defaultValue: review.detail, disable: true)

        guard !review.ownerComment.isEmpty || isOwner else { return }
        form +++ Section("Owner Reply")
            <<< getTextAreaRow(id: "comment", placeholder: "owner reply", defaultValue: review.ownerComment, disable: Condition(booleanLiteral: !isOwner))
    }

    private func updateModel() {
        if let row = form.rowBy(tag: "comment") as? TextAreaRow, let value = row.value { comment = value }
    }

}
