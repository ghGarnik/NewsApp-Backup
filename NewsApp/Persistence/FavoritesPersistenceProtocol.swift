//
//  FavoritesPersistenceProtocol.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation

public protocol FavoritesPersistenceProtocol {
    func saveFavorite(id: Int, completion: SimpleResponse)
    func removeFavorite(id: Int, completion: SimpleResponse)
    func isFavorite(id: Int, completion: TypedAction<Bool>)
    func clearCache()
}
