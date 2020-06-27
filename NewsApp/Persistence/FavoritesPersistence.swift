//
//  FavoritesPersistence.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

final class FavoritesPersistence {
    private let dependencies: FavoritesPersistenceDependenciesProtocol
    private let isFavoriteKey: String

    
    static let isFavoritePath = ".isFavorite"

    init(dependencies: FavoritesPersistenceDependenciesProtocol) {
        self.dependencies = dependencies
        self.isFavoriteKey = dependencies.bundle.description.appending(FavoritesPersistence.isFavoritePath)
    }
}

extension FavoritesPersistence: FavoritesPersistenceProtocol {
    func saveFavorite(id: Int, completion: (SimpleResult) -> ()) {
        guard let favorites = favorites else {
            self.favorites = [id]
            completion(.success)
            return
        }

        if favorites.contains(id) {
            completion(.success)
        }

        self.favorites?.append(id)
        completion(.success)

    }

    func removeFavorite(id: Int, completion: (SimpleResult) -> ()) {
        guard let favorites = favorites,
            favorites.contains(id) else {
                completion(.error)
                return
        }
        self.favorites = favorites.filter { $0 != id }
    }

    func isFavorite(id: Int, completion: (Bool) -> ()) {
        guard let favorites = favorites else {
            completion(false)
            return
        }

        completion(favorites.contains(id))
    }
}

extension FavoritesPersistence: CachePolicy {
    func clearCache() {
        dependencies.userDefaults.set(nil, forKey: isFavoriteKey)
    }
}

extension FavoritesPersistence {
    private var favorites: [Int]? {
        get {
            return dependencies.userDefaults.array(forKey: isFavoriteKey) as? [Int]
        }
        set {
            guard let valueToSet = newValue else { return }
            dependencies.userDefaults.set(valueToSet, forKey: isFavoriteKey)
        }
    }
}
