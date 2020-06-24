//
//  LoginClientDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 24/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol LoginClientDependenciesProtocol {
    var networkManager: HTTPClient { get }
    var sessionManager: SessionManagerProtocol { get }
}

final class LoginClientDependencies: LoginClientDependenciesProtocol {
    lazy var networkManager: HTTPClient = DefaultHTTPClient()
    lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
}
