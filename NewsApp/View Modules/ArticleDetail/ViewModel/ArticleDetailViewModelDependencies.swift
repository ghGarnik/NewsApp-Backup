//
//  ArticleDetailViewModelDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol ArticleDetailViewModelDependenciesProtocol {
    var repository: ArticleDetailClient { get }
    var sessionManager: SessionManagerProtocol { get }
}

public final class ArticleDetailViewModelDependencies: ArticleDetailViewModelDependenciesProtocol {
    public lazy var repository: ArticleDetailClient = DefaultArticleDetailClient(dependencies: DefaultArticleDetailClientDependencies())
    public lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
}
