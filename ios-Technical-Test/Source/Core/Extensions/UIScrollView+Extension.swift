//
//  UIScrollView+Extension.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 16/11/20.
//

import UIKit

extension UIScrollView {
    var isBouncing: Bool {
        return isBouncingTop || isBouncingBottom
    }

    var isBouncingTop: Bool {
        return contentOffset.y < topInsetForBouncing - contentInset.top
    }

    var isBouncingBottom: Bool {
        let threshold: CGFloat
        if contentSize.height > frame.size.height {
            threshold = (self.contentSize.height - frame.size.height + contentInset.bottom + bottomInsetForBouncing)
        } else {
            threshold = topInsetForBouncing
        }
        return contentOffset.y > threshold
    }

    var topInsetForBouncing: CGFloat {
        return safeAreaInsets.top != 0.0 ? -safeAreaInsets.top : 0.0
    }

    var bottomInsetForBouncing: CGFloat {
        return safeAreaInsets.bottom
    }
}
