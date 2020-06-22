//
//  LoginRouter.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import UIKit

final public class LoginRouter: Storyboarded {
    weak private var view: LoginViewController!
    
    init(withView view: LoginViewController) {
        self.view = view
    }
    
    public static func assembleModule() -> UIViewController {
        let viewController: LoginViewController = viewControllerFromStoryboard()
        let router = LoginRouter(withView: viewController)
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
        
    }
    
    func loginDidFail(message: String) {
        view.alert(message)
    }
}
