//
//  LoginViewModelDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol LoginViewModelDependenciesProtocol {
    var loginClient: LoginClient { get }
}

final class LoginViewModelDependencies: LoginViewModelDependenciesProtocol {
    lazy var loginClient: LoginClient = DefaultLoginClient(dependencies: LoginClientDependencies())
}
