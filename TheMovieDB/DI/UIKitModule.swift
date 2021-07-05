//
//  UIKitModule.swift
//  TheMovieDB
//
//  Created by William on 05/07/21.
//  Copyright © 2021 william. All rights reserved.
//

import UIKit
import Cleanse

public struct UIKitModule: Module {
    public static func configure(binder: UnscopedBinder) {
        binder.include(module: UIScreen.Module.self)
        binder.include(module: UIWindow.Module.self)
    }
}

extension UIScreen {
    /// This is a simple module that binds UIScreen.mainScreen() to UIScreen
    public struct Module : Cleanse.Module {
        public static func configure(binder: UnscopedBinder) {
            binder
                .bind(UIScreen.self)
                .to { UIScreen.main }
        }
    }
}

extension UIWindow {
    /// This is the module that configures how we build our main window. It ias assumed when one requests
    /// injection of an un-tagged UIWindow, we will be giving them the "main" or "key" window.
    public struct Module : Cleanse.Module {
        public static func configure(binder: UnscopedBinder) {
            binder
                .bind(UIWindow.self)
                .to { (rootViewController: TaggedProvider<UIViewController.Root>, mainScreen: UIScreen) in
                    let window = UIWindow(frame: mainScreen.bounds)
//                    window.rootViewController = rootViewController.get()
                    window.rootViewController = UINavigationController(rootViewController: rootViewController.get())
                    return window
            }
        }
    }
}

extension UIViewController {
    /// This will represent the rootViewController that is assigned to our main window
    public struct Root : Tag {
        public typealias Element = UIViewController
    }
}
