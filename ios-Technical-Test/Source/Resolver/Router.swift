//
//  Coordinator.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import UIKit
import Swinject
import SwinjectStoryboard

public final class Router {
    public static var storage: StorageManagerProtocol = {
        return StorageManager()
    }()
}

extension Router {

    final class func getListViewController() -> ListViewController? {
        let container = SwinjectStoryboardExtension.container
        let bundle = Bundle(for: Router.self)
        let storyBoard = SwinjectStoryboard.create(name: StoryboardScene.List.storyboardName, bundle: bundle, container: container)
        let viewController: ListViewController? =
            storyBoard.instantiateViewController(withIdentifier: StoryboardScene.List.listViewController.identifier)
            as? ListViewController
        viewController?.modalPresentationStyle = .overFullScreen
        return viewController
    }
}
