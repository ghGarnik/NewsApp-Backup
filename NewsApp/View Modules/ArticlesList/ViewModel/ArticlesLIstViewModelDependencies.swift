//
//  ArticlesLIstViewModelDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol ArticlesListViewModelDependenciesProtocol {
    var sessionManager: SessionManagerProtocol { get }
    var articlesRepository: ArticlesListClient { get }
}

final class ArticlesListViewModelDependencies: ArticlesListViewModelDependenciesProtocol {
    lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
    lazy var articlesRepository: ArticlesListClient = DefaultArticlesListClient(dependencies: DefaultArticlesListClientDependencies())
}
