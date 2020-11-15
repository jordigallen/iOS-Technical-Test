//
//  SwinjectStoryboardExtension.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import Swinject
import SwinjectStoryboard

class SwinjectStoryboardExtension {
    static var container: Container = {
        let container = Container()

        // MARK: - List  ViewController
        container.storyboardInitCompleted(ListViewController.self) { _, c in
            c.presenter = Assembler.shared.resolver.resolve(ListPresenterProtocol.self)
        }

        return container
    }()
}

