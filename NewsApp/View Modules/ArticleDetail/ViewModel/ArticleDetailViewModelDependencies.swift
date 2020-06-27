//
//  ArticleDetailViewModelDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 26/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol ArticleDetailViewModelDependenciesProtocol {
    var repository: ArticleDetailClient { get }
    var sessionManager: SessionManagerProtocol { get }
    var favoritesPersistence: FavoritesPersistenceProtocol { get }
}

final class ArticleDetailViewModelDependencies: ArticleDetailViewModelDependenciesProtocol {
    lazy var repository: ArticleDetailClient = DefaultArticleDetailClient(dependencies: DefaultArticleDetailClientDependencies())
    lazy var sessionManager: SessionManagerProtocol = DefaultSessionManager(dependencies: DefaultSessionManagerDependencies())
    lazy var favoritesPersistence: FavoritesPersistenceProtocol = FavoritesPersistence(dependencies: FavoritesPersistenceDependencies())
}
