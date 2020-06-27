//
//  FavoritesPersistenceDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

protocol FavoritesPersistenceDependenciesProtocol {
    var userDefaults: UserDefaults { get }
    var bundle: Bundle { get }
}

final class FavoritesPersistenceDependencies: FavoritesPersistenceDependenciesProtocol {
    lazy var userDefaults: UserDefaults = UserDefaults.standard
    lazy var bundle: Bundle = Bundle.main
}
