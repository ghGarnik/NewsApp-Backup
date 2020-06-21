//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 21/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol LoginViewModelDependenciesProtocol {
    
}

final class LoginViewModelDependencies: LoginViewModelDependenciesProtocol {
    
}

final class LoginViewModel {
    private let dependencies: LoginViewModelDependenciesProtocol
    private let router: LoginRouterProtocol
    
    init(dependencies: LoginViewModelDependenciesProtocol,
         router: LoginRouterProtocol) {
        self.dependencies = dependencies
        self.router = router
    }
}
