//
//  NewsListRouter.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

public class NewsListRouter: Storyboarded {
    weak private var view: NewsListViewController!
    weak private var coordinator: Coordinator?
    
    init(withView view: NewsListViewController, coordinator: Coordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    public static func assembleModule(coordinator: Coordinator) -> UIViewController {
        let viewController: NewsListViewController = viewControllerFromStoryboard()
        let router = NewsListRouter(withView: viewController, coordinator: coordinator)
        let viewModelDependencies = NewsListViewModelDependencies()
        let viewModel = NewsListViewModel(dependencies: viewModelDependencies, router: router)
        
        viewController.viewModel = viewModel
        return viewController
    }

    static func viewControllerFromStoryboard() -> NewsListViewController {
        return storyboard.instantiateViewController()
    }
}

extension NewsListRouter: NewsListRouterProtocol {
    public func logoutDidSucceed() {
        coordinator?.logoutDidSucceed()
    }
    
    public func logoutDidFail(_ message: String) {
        view.alert(message)
    }
}
