//
//  ArticleDetailRouter.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

public class ArticleDetailRouter: Storyboarded {
    
    private weak var view: ArticleDetailViewController!
    private weak var coordinator: Coordinator?
    
    init(withView view: ArticleDetailViewController, coordinator: Coordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    public static func assembleModule(coordinator: Coordinator, articleId: Int) -> UIViewController {
        let viewController: ArticleDetailViewController = viewControllerFromStoryboard()
        let router = ArticleDetailRouter(withView: viewController, coordinator: coordinator)
        let viewModelDependencies = ArticleDetailViewModelDependencies()
        let viewModel = ArticleDetailViewModel(dependencies: viewModelDependencies,
                                               router: router,
                                               articleId: articleId)
        
        viewController.viewModel = viewModel
        return viewController
    }

    static func viewControllerFromStoryboard() -> ArticleDetailViewController {
        return storyboard.instantiateViewController()
    }
}

extension ArticleDetailRouter: ArticleDetailRouterProtocol {
    public func showMessage(_ message: String, completion: @escaping Action) {
        view.alert(message, completion: completion)
    }
    public func logoutDidSucceed() {
        coordinator?.logoutDidSucceed()
    }
}
