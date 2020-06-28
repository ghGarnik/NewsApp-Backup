//
//  MockDefaultHTTPClientDependencies.swift
//  NewsAppTests
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 28/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation
@testable import NewsApp

final class MockDefaultHTTPClientDependencies: DefaultHTTPClientDependenciesProtocol {
    let sessionManager: SessionManagerProtocol
    let urlSession: URLSessionProtocol
    init (sessionManager: SessionManagerProtocol,
          urlSession: URLSessionProtocol) {
        self.sessionManager = sessionManager
        self.urlSession = urlSession
    }
}
