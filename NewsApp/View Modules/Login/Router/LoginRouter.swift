//
//  LoginRouter.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

final class LoginRouter: Storyboarded {

    private weak var view: LoginViewController!
    private weak var coordinator: Coordinator?

    init(withView view: LoginViewController, coordinator: Coordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    static func assembleModule(coordinator: Coordinator) -> UIViewController {
        let viewController: LoginViewController = viewControllerFromStoryboard()
        let router = LoginRouter(withView: viewController, coordinator: coordinator)
        let dependencies = LoginViewModelDependencies()
        let viewModel = LoginViewModel(dependencies: dependencies,
                                       router: router)
        viewController.viewModel = viewModel
        return viewController
    }

    static func viewControllerFromStoryboard() -> LoginViewController {
        return storyboard.instantiateViewController()
    }
}

extension LoginRouter: LoginRouterProtocol {
    func loginDidSucceed() {
        coordinator?.loginDidSucceed()
    }

    func loginDidFail(message: String) {
        view.alert(message)
    }
}
