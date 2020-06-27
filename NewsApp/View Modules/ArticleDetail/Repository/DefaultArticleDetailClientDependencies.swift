//
//  DefaultArticleDetailClientDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol DefaultArticleDetailClientDependenciesProtocol {
    var network: HTTPClient { get }
}

final class DefaultArticleDetailClientDependencies: DefaultArticleDetailClientDependenciesProtocol {
    lazy var network: HTTPClient = DefaultHTTPClient(dependencies: DefaultHTTPClientDependencies())
}
