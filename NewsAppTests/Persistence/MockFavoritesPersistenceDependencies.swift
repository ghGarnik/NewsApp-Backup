//
//  MockFavoritesPersistenceDependencies.swift
//  NewsAppTests
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

@testable import NewsApp

class MockFavoritesPersistenceDependencies: FavoritesPersistenceDependenciesProtocol {
    private let userDefaultsKey = "garnikH"
    lazy var userDefaults: UserDefaults = UserDefaults.init(suiteName: userDefaultsKey) ?? UserDefaults.standard
    lazy var bundle: Bundle = Bundle.main
}
