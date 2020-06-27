//
//  CacheManagerDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol CacheManagerDependenciesProtocol {
    var cached: [CachePolicy] { get }
}

final class CacheManagerDependencies: CacheManagerDependenciesProtocol {
    lazy var cached: [CachePolicy] = [FavoritesPersistence(dependencies: FavoritesPersistenceDependencies()),
                                      ImagesCache(dependencies: ImagesCacheDependencies())]
}
