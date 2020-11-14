//
//  UIViewController+Extensions.swift
//  PropertyFinder
//
//  Created by JORDI GALLEN on 14/11/2020.
//

import UIKit

extension UIView {

    @discardableResult
    func loadContentView() -> UIView {
        let nibName = type(of: self).description().components(separatedBy: ".").last ?? ""
        let contentView = (Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView) ?? UIView()
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": contentView]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: [], metrics: nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: [], metrics: nil, views: bindings))
        return contentView
    }
}
