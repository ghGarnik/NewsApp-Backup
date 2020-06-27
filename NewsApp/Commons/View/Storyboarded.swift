//
//  Storyboarded.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

protocol Storyboarded: class {

    static var storyboardName: String { get }
    static var storyboard: UIStoryboard { get }
    static func viewControllerFromStoryboard() -> UIViewController
}

extension Storyboarded {

    /// Returns current module Storyboard name based in calling file name.
    /// To be implemented in Routers
    static var storyboardName: String {
        let name = String(describing: self)
        return name.replacingOccurrences(of: "Router", with: "")
    }

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: Bundle(for: Self.self))
    }

    static func viewControllerFromStoryboard() -> UIViewController {
        debugPrint("WARNING! This implementation of viewControllerFromStoryboard should never be called!")
        return UIViewController()
    }
}
