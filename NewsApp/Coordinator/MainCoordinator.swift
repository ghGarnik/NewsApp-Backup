//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

protocol MainCoordinatorDependenciesProtocol {
    var sessionManager: SessionManagerProtocol { get }
}

final class MainCoordinatorDependencies: MainCoordinatorDependenciesProtocol {
    lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
}

final class MainCoordinator {

    private let dependencies: MainCoordinatorDependenciesProtocol
    private let changeNavigationControllerCompletion: (UINavigationController) -> ()
    var navigationController: UINavigationController? {
        didSet {
            guard let navigationController = navigationController else { return }
            changeNavigationControllerCompletion(navigationController)
        }
    }

    init(dependencies: MainCoordinatorDependenciesProtocol, changeNavigationControllerCompletion: @escaping (UINavigationController) -> ()) {
        self.dependencies = dependencies
        self.changeNavigationControllerCompletion = changeNavigationControllerCompletion
    }
}

//MARK: - Coordinator

extension MainCoordinator: Coordinator {
    func start() {
        dependencies.sessionManager.isValidSession(completion: { [weak self] isValid in
            guard let self = self else { return }

            if isValid {
                self.loadArticlesList()
            } else {
                self.loadLoginScreen()
            }
        })
    }

    func loginDidSucceed() {
        dependencies.sessionManager.isValidSession(completion: { [weak self] isValid in
            guard let self = self else { return }

            if isValid {
                self.loadArticlesList()
            } else {
                self.loadLoginScreen()
            }
        })
    }

    func logoutDidSucceed() {
        loadLoginScreen()
    }

    func openArticle(withId id: Int) {
        loadArticleDetail(articleId: id)
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

//MARK: - Article Detail

extension MainCoordinator {
    private func loadArticleDetail(articleId id: Int) {
        let articleDetailView = ArticleDetailRouter.assembleModule(coordinator: self,
                                                                   articleId: id)
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                let navigationController = self.navigationController  else
            {
                return
            }

            navigationController.pushViewController(articleDetailView, animated: true)
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
}
