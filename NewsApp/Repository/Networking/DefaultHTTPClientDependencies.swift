//
//  DefaultHTTPClientDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol DefaultHTTPClientDependenciesProtocol {
    var sessionManager: SessionManagerProtocol { get }
    var urlSession: URLSessionProtocol { get }
}

final class DefaultHTTPClientDependencies: DefaultHTTPClientDependenciesProtocol {
    lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
    lazy var urlSession: URLSessionProtocol = URLSession.shared
}
