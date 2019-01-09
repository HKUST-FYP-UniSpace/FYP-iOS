//
//  WorkingRangeSectionController.swift
//  UniSpace
//
//  Created by KiKan Ng on 5/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import IGListKit
import UIKit

final class WorkingRangeSectionController: ListSectionController, ListWorkingRangeDelegate {

    private var height: Int?
    private var downloadedImage: UIImage?
    private var task: URLSessionDataTask?

    private var urlString: String? {
        guard let height = height,
            let width = collectionContext?.containerSize.width
            else { return nil }
        return "https://unsplash.it/" + width.description + "/" + height.description
    }

    deinit {
        task?.cancel()
    }

    override init() {
        super.init()
        workingRangeDelegate = self
    }

    override func numberOfItems() -> Int {
        return 2
    }

    override func sizeForItem(at index: Int) -> CGSize {
        let width: CGFloat = collectionContext?.containerSize.width ?? 0
        let height: CGFloat = CGFloat(index == 0 ? 55 : (self.height ?? 0))
        return CGSize(width: width, height: height)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cellClass: AnyClass = index == 0 ? LabelCell.self : ImageCell.self
        let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
        if let cell = cell as? LabelCell {
            cell.text = urlString
        } else if let cell = cell as? ImageCell {
            cell.setImage(image: downloadedImage)
        }
        return cell
    }

    override func didUpdate(to object: Any) {
        self.height = object as? Int
    }

    // MARK: ListWorkingRangeDelegate

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        guard downloadedImage == nil,
            task == nil,
            let urlString = urlString,
            let url = URL(string: urlString)
            else { return }

        print("Downloading image \(urlString) for section \(self.section)")

        task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                return print("Error downloading \(urlString): " + String(describing: error))
            }
            DispatchQueue.main.async {
                self.downloadedImage = image
                if let cell = self.collectionContext?.cellForItem(at: 1, sectionController: self) as? ImageCell {
                    cell.setImage(image: image)
                }
            }
        }
        task?.resume()
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {}

}
