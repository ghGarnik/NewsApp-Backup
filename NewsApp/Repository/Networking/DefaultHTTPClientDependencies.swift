//
//  DefaultHTTPClientDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol DefaultHTTPClientDependenciesProtocol {
    var sessionManager: SessionManagerProtocol { get }
}

public final class DefaultHTTPClientDependencies: DefaultHTTPClientDependenciesProtocol {
    public lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
}
