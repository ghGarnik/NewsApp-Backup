//
//  CacheManager.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public final class CacheManager {
    
    private let dependencies: CacheManagerDependenciesProtocol
    
    init(dependencies: CacheManagerDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

extension CacheManager: CacheManagerProtocol {
    public func wipeAppCache() {
        dependencies.cached.forEach { $0.clearCache() }
    }
}
