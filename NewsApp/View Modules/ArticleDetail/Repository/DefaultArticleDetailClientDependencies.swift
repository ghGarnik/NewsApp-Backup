//
//  DefaultArticleDetailClientDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol DefaultArticleDetailClientDependenciesProtocol {
    var network: HTTPClient { get }
}

public final class DefaultArticleDetailClientDependencies: DefaultArticleDetailClientDependenciesProtocol {
    public lazy var network: HTTPClient = DefaultHTTPClient(dependencies: DefaultHTTPClientDependencies())
}
