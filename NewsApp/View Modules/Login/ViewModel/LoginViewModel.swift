//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

final class LoginViewModel {
    private let dependencies: LoginViewModelDependenciesProtocol
    private let router: LoginRouterProtocol

    init(dependencies: LoginViewModelDependenciesProtocol,
         router: LoginRouterProtocol) {
        self.dependencies = dependencies
        self.router = router
    }
}

//MARK: ViewModel Protocol
extension LoginViewModel: LoginViewModelProtocol {
    func didTapOnLogin(username: String, password: String) {
        let credentials = LoginCredentials(username: username, password: password)
        dependencies.loginClient.login(credentials, completion: { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .successful:
                self.router.loginDidSucceed()
            case .failure(let message):
                self.router.loginDidFail(message: message)
            }
        })
    }
}
