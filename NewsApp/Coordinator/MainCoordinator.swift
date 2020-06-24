//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

public protocol MainCoordinatorDependenciesProtocol {
    var sessionManager: SessionManagerProtocol { get }
}

public class MainCoordinatorDependencies: MainCoordinatorDependenciesProtocol {
    lazy public var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
}

public class MainCoordinator {
    
    private let dependencies: MainCoordinatorDependenciesProtocol
    private let navigationController: UINavigationController
    
    public init(dependencies: MainCoordinatorDependenciesProtocol, navigationController: UINavigationController) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
}

extension MainCoordinator {
    private func loadLoginScreen() {
        let loginView = LoginRouter.assembleModule(coordinator: self)
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(loginView, animated: true)
        navigationController.setNavigationBarHidden(true, animated: false)
        let numberOfViewControllers = navigationController.viewControllers.count
        if numberOfViewControllers > 1 {
            navigationController.viewControllers.removeSubrange(1...numberOfViewControllers)
        }
    }
}

extension MainCoordinator: Coordinator {
    public func start() {
        dependencies.sessionManager.isValidSession(completion: { [weak self] isValid in
            guard let self = self else {
                return
            }
            if isValid {
                //TODO: load next screen
                self.loadLoginScreen()
            } else {
                self.loadLoginScreen()
            }
        })
    }
    
    public func loginDidSucceed() {
        dependencies.sessionManager.isValidSession(completion: { [weak self] isValid in
            guard let self = self else {
                return
            }
            if isValid {
                //TODO: load articles
            } else {
                self.loadLoginScreen()
            }
        })
    }
}
