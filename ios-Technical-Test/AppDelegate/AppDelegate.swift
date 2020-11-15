//
//  AppDelegate.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 12/11/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = Router.getListViewController()
        self.window?.makeKeyAndVisible()
        return true
    }
}

