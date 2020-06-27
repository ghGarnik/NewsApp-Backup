//
//  DefaultArticlesListDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol DefaultArticlesListClientDependenciesProtocol {
    var network: HTTPClient { get }
}

final class DefaultArticlesListClientDependencies: DefaultArticlesListClientDependenciesProtocol {
    lazy var network: HTTPClient = DefaultHTTPClient(dependencies: DefaultHTTPClientDependencies())
}
