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
    private let changeNavigationControllerCompletion: (UINavigationController) -> ()
    public var navigationController: UINavigationController? {
        didSet {
            guard let navigationController = navigationController else { return }
            changeNavigationControllerCompletion(navigationController)
        }
    }
    
    public init(dependencies: MainCoordinatorDependenciesProtocol, changeNavigationControllerCompletion: @escaping (UINavigationController) -> ()) {
        self.dependencies = dependencies
        self.changeNavigationControllerCompletion = changeNavigationControllerCompletion
    }
}

//MARK: - Coordinator

extension MainCoordinator: Coordinator {
    public func start() {
        dependencies.sessionManager.isValidSession(completion: { [weak self] isValid in
            guard let self = self else { return }
            
            if isValid {
                self.loadArticlesList()
            } else {
                self.loadLoginScreen()
            }
        })
    }
    
    public func loginDidSucceed() {
        dependencies.sessionManager.isValidSession(completion: { [weak self] isValid in
            guard let self = self else { return }
            
            if isValid {
                self.loadArticlesList()
            } else {
                self.loadLoginScreen()
            }
        })
    }
    
    public func logoutDidSucceed() {
        loadLoginScreen()
    }
}

//MARK: - Load Login

extension MainCoordinator {
    private func loadLoginScreen() {
        let loginView = LoginRouter.assembleModule(coordinator: self)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let navigationController = UINavigationController()
            navigationController.pushViewController(loginView, animated: true)
            navigationController.setNavigationBarHidden(true, animated: false)
            self.navigationController = navigationController
        }
    }
}

//MARK: - Articles List

extension MainCoordinator {
    private func loadArticlesList() {
        let articlesListView = ArticlesListRouter.assembleModule(coordinator: self)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let navigationController = UINavigationController()
            navigationController.pushViewController(articlesListView, animated: true)
            navigationController.setNavigationBarHidden(false, animated: false)
            self.navigationController = navigationController
        }
    }
}
