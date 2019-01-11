//
//  CollectionView+SnapToCell.swift
//  UniSpace
//
//  Created by KiKan Ng on 11/1/2019.
//  Copyright © 2019 KiKan Ng. All rights reserved.
//

import UIKit

extension UICollectionView {
    func snapToCell(velocity: CGPoint, targetOffset: UnsafeMutablePointer<CGPoint>, contentInset: CGFloat = 0, spacing: CGFloat = 0) {
        // No snap needed as we're at the end of the scrollview
        guard (contentOffset.x + frame.size.width) < contentSize.width else { return }
        guard let indexPath = indexPathForItem(at: targetOffset.pointee) else { return }
        guard let cellLayout = layoutAttributesForItem(at: indexPath) else { return }

        var offset = targetOffset.pointee

        if velocity.x < 0 {
            offset.x = cellLayout.frame.minX - max(contentInset, spacing)
        } else {
            offset.x = cellLayout.frame.maxX - contentInset + min(contentInset, spacing)
        }

        offset.x -= spacing
        targetOffset.pointee = offset
    }
}
