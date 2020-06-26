//
//  DefaultArticlesListDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol DefaultArticlesListClientDependenciesProtocol {
    var network: HTTPClient { get }
}

public final class DefaultArticlesListClientDependencies: DefaultArticlesListClientDependenciesProtocol {
    public lazy var network: HTTPClient = DefaultHTTPClient(dependencies: DefaultHTTPClientDependencies())
    public lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
}
