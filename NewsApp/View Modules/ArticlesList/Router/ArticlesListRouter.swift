//
//  ArticlesListRouter.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

class ArticlesListRouter: Storyboarded {

    private weak var view: ArticlesListViewController!
    private weak var coordinator: Coordinator?

    init(withView view: ArticlesListViewController, coordinator: Coordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    static func assembleModule(coordinator: Coordinator) -> UIViewController {
        let viewController: ArticlesListViewController = viewControllerFromStoryboard()
        let router = ArticlesListRouter(withView: viewController, coordinator: coordinator)
        let viewModelDependencies = ArticlesListViewModelDependencies()
        let viewModel = ArticlesListViewModel(dependencies: viewModelDependencies, router: router)

        viewController.viewModel = viewModel
        return viewController
    }

    static func viewControllerFromStoryboard() -> ArticlesListViewController {
        return storyboard.instantiateViewController()
    }
}

extension ArticlesListRouter: ArticlesListRouterProtocol {
    func showMessage(_ message: String, completion: @escaping Action) {
        view.alert(message, completion: completion)
    }

    func navigateToArticle(_ articleId: Int) {
        coordinator?.openArticle(withId: articleId)
    }

    func logoutDidSucceed() {
        coordinator?.logoutDidSucceed()
    }
}
