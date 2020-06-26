//
//  ArticlesLIstViewModelDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 25/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol ArticlesListViewModelDependenciesProtocol {
    var sessionManager: SessionManagerProtocol { get }
    var articlesRepository: ArticlesListClient { get }
}

public class ArticlesListViewModelDependencies: ArticlesListViewModelDependenciesProtocol {
    public lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
    public lazy var articlesRepository: ArticlesListClient = DefaultArticlesListClient(dependencies: DefaultArticlesListClientDependencies())
}
