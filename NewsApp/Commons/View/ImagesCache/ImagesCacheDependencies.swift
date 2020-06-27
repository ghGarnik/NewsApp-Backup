//
//  ImagesCacheDependencies.swift
//  NewsApp
//
//  Created by HARUTYUNYAN LAPUSHNYAN Garnik on 27/06/2020.
//  Copyright © 2020 HARUTYUNYAN LAPUSHNYAN Garnik. All rights reserved.
//

import Foundation
import Kingfisher

protocol ImagesCacheDependenciesProtocol {
    var imageCache: ImageCache { get }
}

final class ImagesCacheDependencies: ImagesCacheDependenciesProtocol {
    lazy var imageCache: ImageCache = ImageCache.default
}
