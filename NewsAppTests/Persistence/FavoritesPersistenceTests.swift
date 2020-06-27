//
//  FavoritesPersistenceTests.swift
//  NewsAppTests
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import XCTest
@testable import NewsApp

class FavoritesPersistenceTests: XCTestCase {
    
    var dependencies: FavoritesPersistenceDependenciesProtocol!
    var sut: FavoritesPersistenceProtocol!
    var favoriteId: Int!
    var favoritesKey: String!
    
    override func setUp() {
        super.setUp()
        dependencies = MockFavoritesPersistenceDependencies()
        sut = FavoritesPersistence(dependencies: dependencies)
        favoritesKey = dependencies.bundle.description.appending(FavoritesPersistence.isFavoritePath)
        favoriteId = Int.random(in: 1...300)
    }
    
    override func tearDown() {
        favoriteId = nil
        sut = nil
        dependencies.userDefaults.set(nil, forKey: favoritesKey)
        favoritesKey = nil
        dependencies = nil
        
        super.tearDown()
    }
    
    func testFavoriteIsSaved() {
        sut.saveFavorite(id: favoriteId) { result in
            switch result {
            case .success:
                guard let favorites = dependencies.userDefaults.array(forKey: favoritesKey) as? [Int] else {
                    XCTFail()
                    return
                }
                XCTAssert(favorites.contains(favoriteId),  "Favorite haven't been saved properly")
            case .error:
                XCTFail()
            }
        }
    }
    
    func testIsFavorite() {
        dependencies.userDefaults.set([favoriteId], forKey: favoritesKey)
        sut.isFavorite(id: favoriteId) { isFavorite in
            XCTAssert(isFavorite, "favorite not stored properly")
        }
    }
    
    func testFavoriteIsRemoved() {
        dependencies.userDefaults.set([favoriteId, 42, 75], forKey: favoritesKey)
        sut.removeFavorite(id: favoriteId) { removeResult in
            switch removeResult {
            case .success:
                guard let favorites = dependencies.userDefaults.array(forKey: favoritesKey) as? [Int] else {
                    XCTFail()
                    return
                }
                XCTAssert(favorites.contains(favoriteId), "Favorite haven't been removed")
            case .error:
                XCTFail()
            }
        }
    }
    
    func testCacheIsCleared() {
        dependencies.userDefaults.set([4, 25, 221], forKey: favoritesKey)
        sut.isFavorite(id: 4) { result in
            if result {
                sut.clearCache()
                let favorites = dependencies.userDefaults.array(forKey: favoritesKey)
                XCTAssertNil(favorites, "Favorites cache contains elements")
            } else {
                XCTFail()
            }
        }
    }
}
