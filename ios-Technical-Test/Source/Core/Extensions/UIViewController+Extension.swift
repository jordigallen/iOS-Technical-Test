//
//  UIViewController+Extension.swift
//  PropertyFinder
//
//  Created by JORDI GALLEN on 14/11/2020.
//

import UIKit

extension UIViewController {

    func createGenericAlert(_ title: String, with description: String, and actionLabel: String) {
        let alert = UIAlertController(title: title, message:  description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionLabel, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
