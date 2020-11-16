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

    final class func getDetailViewController(_ image: UIImageView?, title: String?, gender: String?, sinopsis: String?, puntuation: Double?) -> UINavigationController? {
        let container = SwinjectStoryboardExtension.container
        let bundle = Bundle(for: Router.self)
        let storyBoard = SwinjectStoryboard.create(name: StoryboardScene.Detail.storyboardName, bundle: bundle, container: container)
        let navigationController = storyBoard.instantiateInitialViewController() as? UINavigationController
        if let viewController = storyBoard.instantiateViewController(withIdentifier: StoryboardScene.Detail.detailListViewController.identifier) as? DetailListViewController {
            viewController.imageDetail = image
            viewController.titleDetail = title
            viewController.genderDetail = gender
            viewController.sinopsisDetail = sinopsis
            viewController.puntuation = puntuation
            navigationController?.addChild(viewController)
            viewController.modalPresentationStyle = .overFullScreen
            return navigationController
        }
        return UINavigationController()
    }
}
