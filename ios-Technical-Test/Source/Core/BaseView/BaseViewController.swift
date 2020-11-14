//
//  BaseViewController.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import UIKit
import UserNotifications

@objc public protocol BaseUI: AnyObject {
    func showGenericError()
    func showMaintenanceError()
    func showConectionError()
}

@objc public protocol BaseViewControllerProtocol: BaseUI {
    func showGenericError(_ notification: NSNotification)
}

extension BaseViewControllerProtocol {
    func bindNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showGenericError), name: Notification.Name.Error.Remote.generic, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showGenericError), name: Notification.Name.Error.Remote.maintenance, object: nil)
    }

    func unBindNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.Error.Remote.generic, object: nil)
    }
}

open class BaseViewController: UIViewController, BaseViewControllerProtocol {
    public func showGenericError() {
        self.createGenericAlert(L10n.IosTechnicalTest.ErrorNetwork.Connection.title, with: L10n.IosTechnicalTest.ErrorNetwork.Connection.description, and: L10n.Shared.accept)
    }

    public func showMaintenanceError() {
        self.createGenericAlert(L10n.IosTechnicalTest.ErrorNetwork.Maintenance.title, with: L10n.IosTechnicalTest.ErrorNetwork.Maintenance.description, and: L10n.Shared.accept)

    }

    public func showConectionError() {
        self.createGenericAlert(L10n.IosTechnicalTest.ErrorNetwork.Connection.title, with: L10n.IosTechnicalTest.ErrorNetwork.Connection.description, and: L10n.Shared.accept)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLoading()
        self.bindNotifications()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideLoading()
        self.unBindNotifications()
    }

    public func showLoading() {
        CoreLog.ui.debug("Show loading...")
    }

    public func hideLoading() {
        CoreLog.ui.debug("Hide loading...")
    }

    public func showGenericError(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            CoreLog.ui.error("Generic error received...")
            return
        }
        let error = userInfo[ErrorType.generic].debugDescription
        CoreLog.ui.error("%@", error)

    }
}

