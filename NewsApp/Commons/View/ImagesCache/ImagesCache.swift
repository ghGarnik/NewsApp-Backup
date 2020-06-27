//
//  ImagesCache.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

final class ImagesCache {
    private let dependencies: ImagesCacheDependenciesProtocol

    init(dependencies: ImagesCacheDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

extension ImagesCache: CachePolicy {
    func clearCache() {
        dependencies.imageCache.clearMemoryCache()
        dependencies.imageCache.clearDiskCache()
    }
}
